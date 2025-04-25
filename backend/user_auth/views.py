# user_auth/views.py
from .forms import CustomUserCreationForm
from .forms import BoardForm
from backend.nodes.models import Board, Node
from .forms import NodeForm
from django.shortcuts import get_object_or_404, redirect, render
from django.contrib.auth.decorators import login_required
from backend.nodes.models import Node
from .utils import fetch_wikidata_properties_by_name
from django.contrib import messages
from .forms import ManualPropertyForm
from .utils import map_properties_to_form_initial, FORM_LABEL_TO_PROPERTY_LABEL
from django.contrib.auth import logout

def custom_logout_view(request):
    logout(request)
    return render(request, "registration/logged_out.html")



def delete_node(request, node_id):
    node = get_object_or_404(Node, id=node_id)
    board_id = node.board.id
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
            'title': 'title',
            'published in': 'published_in',
            'name in native language': 'name_in_native_language',
            'applies to part': 'applies_to_part',
            'point in time': 'point_in_time'
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
    board = Board.objects.get(id=board_id, owner=request.user)

    if request.method == 'POST':
        form = NodeForm(request.POST)
        if form.is_valid():
            node = form.save(commit=False)
            node.board = board
            node.save()
            return redirect('board_detail', board_id=board.id)
    else:
        form = NodeForm()

    return render(request, 'registration/create_node.html', {'form': form, 'board': board})

@login_required
def board_detail(request, board_id):
    board = Board.objects.get(id=board_id, owner=request.user)  # secure ownership check
    nodes = board.nodes.all()  # all nodes related to this board

    return render(request, 'registration/board_detail.html', {
        'board': board,
        'nodes': nodes
    })


@login_required
def home_view(request):
    user_boards = Board.objects.filter(owner=request.user)
    return render(request, 'registration/home.html', {'boards': user_boards})

def register(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
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
            board.save()
            return redirect('home')  # or redirect to a board list page if you prefer
    else:
        form = BoardForm()
    return render(request, 'registration/create_board.html', {'form': form})

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
