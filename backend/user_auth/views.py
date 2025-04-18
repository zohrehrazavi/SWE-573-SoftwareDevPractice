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
        for key, value in request.POST.items():
            if key.startswith("property_") and value:
                field = key.replace("property_", "")
                approved_props[field] = value

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


@login_required
def add_manual_property(request, node_id):
    node = get_object_or_404(Node, id=node_id)
    edited_field = request.GET.get("edit")

    if request.method == "POST":
        form = ManualPropertyForm(request.POST)
        if form.is_valid():
            for field_name, value in form.cleaned_data.items():
                if value:
                    if not node.properties:
                        node.properties = {}
                    label = FORM_LABEL_TO_PROPERTY_LABEL.get(field_name, field_name)
                    node.properties[label] = value
            node.save()
            return redirect("add_manual_property", node_id=node.id)
    else:
        initial_data = map_properties_to_form_initial(node.properties or {})
        form = ManualPropertyForm(initial=initial_data)

    return render(request, "registration/add_property.html", {
        "form": form,
        "node": node,
        "edited_field": edited_field  # Pass to template
    })

@login_required
def custom_logout(request):
    logout(request)
    return render(request, 'registration/logout.html')
