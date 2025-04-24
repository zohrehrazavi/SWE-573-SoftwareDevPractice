from rest_framework import generics
from .serializers import NodeSerializer
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import Node, Board, ManualEdge, Edge
from django.views.decorators.http import require_GET, require_http_methods
import json

@login_required
def save_manual_edge(request):
    if request.method == "POST":
        from_id = request.POST.get("from")
        to_id = request.POST.get("to")
        board_id = request.POST.get("board")
        label = request.POST.get("label", "").strip()

        if not label:
            return JsonResponse({"status": "error", "message": "Edge label is required"}, status=400)
        
        if len(label) > 50:
            return JsonResponse({"status": "error", "message": "Edge label is too long (maximum 50 characters)"}, status=400)

        try:
            board = Board.objects.get(id=board_id, owner=request.user)
            from_node = Node.objects.get(id=from_id, board=board)
            to_node = Node.objects.get(id=to_id, board=board)
            ManualEdge.objects.get_or_create(
                board=board, 
                from_node=from_node, 
                to_node=to_node,
                defaults={'label': label}
            )
            return JsonResponse({"status": "ok"})
        except:
            return JsonResponse({"status": "error"}, status=400)

@login_required
def delete_manual_edge(request):
    if request.method == "POST":
        from_id = request.POST.get("from")
        to_id = request.POST.get("to")
        board_id = request.POST.get("board")

        ManualEdge.objects.filter(
            board_id=board_id,
            from_node_id=from_id,
            to_node_id=to_id
        ).delete()

        return JsonResponse({"status": "deleted"})

@login_required
def graph_preview(request, board_id):
    try:
        board = Board.objects.get(id=board_id, owner=request.user)
    except Board.DoesNotExist:
        return render(request, "not_found.html", {"message": "Board not found."})

    return render(request, "graph.html", {"board_id": board.id})

@require_http_methods(["POST"])
def create_manual_edge(request):
    try:
        data = json.loads(request.body)
        from_node_id = data.get('from_node_id')
        to_node_id = data.get('to_node_id')
        board_id = data.get('board_id')
        label = data.get('label', '')  # Get label with empty string as default

        # Validate input
        if not all([from_node_id, to_node_id, board_id]):
            return JsonResponse({'status': 'error', 'message': 'Missing required fields'}, status=400)

        # Get the board and verify ownership
        board = Board.objects.get(id=board_id, user=request.user)
        
        # Get the nodes
        from_node = Node.objects.get(id=from_node_id, board=board)
        to_node = Node.objects.get(id=to_node_id, board=board)

        # Check if edge already exists
        if Edge.objects.filter(from_node=from_node, to_node=to_node, board=board).exists():
            return JsonResponse({'status': 'error', 'message': 'Edge already exists'}, status=400)

        # Create the edge with the label
        edge = Edge.objects.create(
            from_node=from_node,
            to_node=to_node,
            board=board,
            label=label
        )

        return JsonResponse({'status': 'success', 'message': 'Edge created successfully'})

    except Board.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Board not found'}, status=404)
    except Node.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Node not found'}, status=404)
    except json.JSONDecodeError:
        return JsonResponse({'status': 'error', 'message': 'Invalid JSON'}, status=400)
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)}, status=500)

class NodeListCreateView(generics.ListCreateAPIView):
    queryset = Node.objects.all()
    serializer_class = NodeSerializer