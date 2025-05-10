# user_auth/views.py
from .forms import (
    CustomUserCreationForm,
    BoardForm,
    NodeForm,
    ManualPropertyForm,
    PasswordResetRequestForm,
    SetNewPasswordForm
)
from backend.nodes.models import Board, Node
from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from backend.nodes.models import Node
from .utils import fetch_wikidata_properties_by_name
from django.contrib import messages
from .utils import map_properties_to_form_initial, FORM_LABEL_TO_PROPERTY_LABEL
from django.contrib.auth import logout, authenticate, login
from django.http import HttpResponseForbidden, JsonResponse
from django.urls import reverse
from backend.nodes.models import ContributionMessage
from django.contrib.auth.models import User
from django.db import models
from .models import SecurityQuestion, UserSecurityAnswer
import datetime

def custom_logout_view(request):
    logout(request)
    return render(request, 'registration/logout.html')



def delete_node(request, node_id):
    node = get_object_or_404(Node, id=node_id)
    board_id = node.board.id
    # Only allow board owner or node creator to delete
    if not (node.board.owner == request.user or node.created_by == request.user):
        return HttpResponseForbidden("You do not have permission to delete this node.")
    node.delete()
    return redirect('board_detail', board_id=board_id)


@login_required
def node_detail(request, node_id):
    node = get_object_or_404(Node, id=node_id)
    return render(request, 'registration/node_detail.html', {'node': node})

@login_required
def fetch_node_properties(request, node_id):
    node = get_object_or_404(Node, id=node_id)

    wikidata_id, enriched_props = fetch_wikidata_properties_by_name(node.name)

    if not wikidata_id:
        messages.warning(request, f"No Wikidata ID found for: {node.name}")
        return redirect("node_detail", node_id=node.id)

    # Store suggestions temporarily in session
    request.session["suggested_properties"] = enriched_props
    request.session["wikidata_id"] = wikidata_id

    return redirect("review_node_properties", node_id=node.id)
@login_required
def review_node_properties(request, node_id):
    node = get_object_or_404(Node, id=node_id)
    suggested_properties = request.session.get("suggested_properties", {})

    return render(request, "registration/review_node_properties.html", {
        "node": node,
        "suggested_properties": suggested_properties
    })

@login_required
def approve_node_properties(request, node_id):
    node = get_object_or_404(Node, id=node_id)

    if request.method == "POST":
        approved_props = {}
        property_mapping = {
            # Basic Information
            'instance of': 'instance_of',
            'occupation': 'occupation',
            'gender': 'gender',
            'country of citizenship': 'country_of_citizenship',
            'date of birth': 'date_of_birth',
            'date of death': 'date_of_death',
            'place of birth': 'place_of_birth',
            'place of death': 'place_of_death',
            'residence': 'residence',
            'family name': 'family_name',
            'given name': 'given_name',
            'ethnic group': 'ethnic_group',
            'eye color': 'eye_color',
            'hair color': 'hair_color',
            'hair type': 'hair_type',
            
            # Case-Specific
            'title': 'title',
            'published in': 'published_in',
            'name in native language': 'name_in_native_language',
            'applies to part': 'applies_to_part',
            'point in time': 'point_in_time',
            
            # Report Details
            'report title': 'report_title',
            'report source': 'report_source',
            'report date': 'report_date',
            
            # Witness Information
            'witness name': 'witness_name',
            'witness account': 'witness_account',
            'statement platform': 'statement_platform',
            
            # Event Information
            'event type': 'event_type',
            'event date': 'event_date',
            'event location': 'event_location',
            
            # Media Evidence
            'media title': 'media_title',
            'media source': 'media_source',
            'media date': 'media_date',
            
            # Discovery Information
            'discovery date': 'discovery_date',
            'discovery location': 'discovery_location',
            'discovered by': 'discovered_by'
        }

        for key, value in request.POST.items():
            if key.startswith("property_") and value:
                # Remove the "property_" prefix
                field = key.replace("property_", "")
                # Map the field to its underscore version
                field_name = property_mapping.get(field, field)
                approved_props[field_name] = value

        node.properties = approved_props
        node.save()

        request.session.pop("suggested_properties", None)
        request.session.pop("wikidata_id", None)

        return redirect("node_detail", node_id=node.id)

    return redirect("review_node_properties", node_id=node.id)


@login_required
def create_node(request, board_id):
    from backend.nodes.models import BoardEditor
    board = get_object_or_404(Board, id=board_id)
    # Check if user is owner or editor
    is_editor = (board.owner == request.user) or board.editors.filter(user=request.user).exists()
    if not is_editor:
        return HttpResponseForbidden("You do not have permission to add nodes to this board.")

    if request.method == 'POST':
        form = NodeForm(request.POST)
        if form.is_valid():
            node = form.save(commit=False)
            node.board = board
            node.created_by = request.user
            node.save()
            return redirect('board_detail', board_id=board.id)
    else:
        form = NodeForm()

    return render(request, 'registration/create_node.html', {'form': form, 'board': board})

@login_required
def board_detail(request, board_id):
    board = Board.objects.get(id=board_id)
    nodes = board.nodes.all()  # all nodes related to this board
    is_board_editor = (board.owner == request.user) or board.editors.filter(user=request.user).exists()
    messages = ContributionMessage.objects.filter(board=board).order_by('created_at')
    
    # Get all contributors: board owner, editors, node creators, message authors
    contributors = User.objects.filter(
        models.Q(id=board.owner.id) |  # Board owner
        models.Q(boardeditor__board=board) |  # Board editors
        models.Q(created_nodes__board=board) |  # Node creators
        models.Q(created_manual_edges__board=board) |  # Edge creators
        models.Q(contributionmessage__board=board)  # Message authors
    ).distinct()
    
    return render(request, 'registration/board_detail.html', {
        'board': board,
        'nodes': nodes,
        'is_board_editor': is_board_editor,
        'messages': messages,
        'contributors': contributors,
    })


@login_required
def home_view(request):
    show = request.GET.get('show', 'my')
    if show == 'all':
        boards = Board.objects.all()
    else:
        boards = Board.objects.filter(owner=request.user)
    is_board_owner = Board.objects.filter(owner=request.user).exists()
    return render(request, 'registration/home.html', {'boards': boards, 'show': show, 'is_board_owner': is_board_owner})

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            
            # Create elementary school security question if it doesn't exist
            question, _ = SecurityQuestion.objects.get_or_create(
                question_type='elementary_school'
            )
            
            # Save security answer
            UserSecurityAnswer.objects.create(
                user=user,
                question=question,
                answer=form.cleaned_data['elementary_school'].lower().strip()
            )
            
            return redirect('login')
    else:
        form = CustomUserCreationForm()
    return render(request, 'registration/register.html', {'form': form})

@login_required
def create_board(request):
    if request.method == 'POST':
        form = BoardForm(request.POST)
        if form.is_valid():
            board = form.save(commit=False)
            board.owner = request.user
            board.board_tags = form.cleaned_data['board_tags']
            board.save()
            return redirect('home')
    else:
        form = BoardForm()
    return render(request, 'registration/create_board.html', {'form': form})

@login_required
def edit_board(request, board_id):
    board = get_object_or_404(Board, id=board_id, owner=request.user)
    if request.method == 'POST':
        form = BoardForm(request.POST, instance=board)
        if form.is_valid():
            board = form.save(commit=False)
            board.owner = request.user
            board.board_tags = form.cleaned_data['board_tags']
            board.save()
            return redirect('board_detail', board_id=board.id)
    else:
        # Prepopulate the tags as a comma-separated string for the JS tags input
        initial = {'board_tags': ', '.join(board.board_tags) if board.board_tags else ''}
        form = BoardForm(instance=board, initial=initial)
    return render(request, 'registration/create_board.html', {'form': form, 'edit_mode': True, 'board': board})

def organize_properties_into_sections(properties):
    sections = {
        'Basic Information': ['instance_of', 'occupation'],
        'Personal Details': ['gender', 'country_of_citizenship', 'family_name', 'given_name', 'name_in_native_language'],
        'Biographical Data': ['date_of_birth', 'date_of_death', 'place_of_birth', 'place_of_death', 'residence', 'ethnic_group'],
        'Physical Characteristics': ['eye_color', 'hair_color', 'hair_type'],
        'Additional Information': ['title', 'published_in', 'applies_to_part', 'point_in_time']
    }
    
    organized_properties = {section: {} for section in sections}
    
    if properties:
        for prop_name, value in properties.items():
            for section, props in sections.items():
                if prop_name in props:
                    organized_properties[section][prop_name] = value
                    break
    
    return organized_properties

@login_required
def add_manual_property(request, node_id):
    node = get_object_or_404(Node, id=node_id)
    edited_field = request.GET.get("edit")

    if request.method == "POST":
        form = ManualPropertyForm(request.POST)
        if form.is_valid():
            if not node.properties:
                node.properties = {}
            for field_name, value in form.cleaned_data.items():
                if value:
                    # Convert date objects to ISO format strings
                    if isinstance(value, (datetime.date, datetime.datetime)):
                        value = value.isoformat()
                    # Use the field name directly as it already has underscores
                    node.properties[field_name] = value
            node.save()
            return redirect("node_detail", node_id=node.id)
    else:
        # Use the properties directly as they should already have underscores
        initial_data = node.properties or {}
        form = ManualPropertyForm(initial=initial_data)

    organized_properties = organize_properties_into_sections(node.properties or {})
    
    return render(request, "registration/add_property.html", {
        "form": form,
        "node": node,
        "edited_field": edited_field,
        "organized_properties": organized_properties
    })

@login_required
def custom_logout(request):
    logout(request)
    return render(request, 'registration/logout.html')

@login_required
def delete_board(request, board_id):
    board = get_object_or_404(Board, id=board_id, owner=request.user)
    if request.method == 'POST':
        board.delete()
        return redirect('home')
    return redirect('home')

def edit_node_description(request, node_id):
    node = Node.objects.get(id=node_id)
    if request.method == 'POST':
        new_desc = request.POST.get('description', '')
        node.description = new_desc
        node.save()
        return redirect(reverse('node_detail', args=[node.id]))
    return render(request, 'registration/edit_node_description.html', {'node': node})

@login_required
def update_board_description(request, board_id):
    if request.method != 'POST':
        return JsonResponse({'success': False, 'error': 'Invalid method'})
    
    board = get_object_or_404(Board, id=board_id)
    
    # Only allow board owner to update description
    if board.owner != request.user:
        return JsonResponse({'success': False, 'error': 'Only board owner can update the description'})
    
    description = request.POST.get('description', '').strip()
    if len(description) > 500:
        return JsonResponse({'success': False, 'error': 'Description too long'})
    
    board.description = description
    board.save()
    
    return JsonResponse({'success': True})

def password_reset_request(request):
    # Ensure the elementary school security question exists
    SecurityQuestion.objects.get_or_create(question_type='elementary_school')
    
    if request.method == 'POST':
        form = PasswordResetRequestForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            answer = form.cleaned_data['answer'].lower().strip()
            
            try:
                user = User.objects.get(username=username)
                security_answer = UserSecurityAnswer.objects.get(
                    user=user,
                    question__question_type='elementary_school'
                )
                
                if security_answer.answer == answer:
                    request.session['reset_user_id'] = user.id
                    return redirect('password_reset_confirm')
                else:
                    form.add_error(None, "The answer is incorrect.")
            except (User.DoesNotExist, UserSecurityAnswer.DoesNotExist):
                form.add_error(None, "User not found or security question not set.")
    else:
        form = PasswordResetRequestForm()
    
    return render(request, 'registration/password_reset_request.html', {'form': form})

def password_reset_confirm(request):
    # Check if user is authorized to reset password
    user_id = request.session.get('reset_user_id')
    if not user_id:
        return redirect('password_reset_request')
    
    try:
        user = User.objects.get(id=user_id)
    except User.DoesNotExist:
        return redirect('password_reset_request')
    
    if request.method == 'POST':
        form = SetNewPasswordForm(request.POST)
        if form.is_valid():
            # Set new password
            user.set_password(form.cleaned_data['new_password1'])
            user.save()
            
            # Clear session
            del request.session['reset_user_id']
            
            return redirect('login')
    else:
        form = SetNewPasswordForm()
    
    return render(request, 'registration/password_reset_confirm.html', {'form': form})

def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            messages.error(request, 'Invalid username or password. Please try again.')
            return render(request, 'registration/login.html')
    
    return render(request, 'registration/login.html')
