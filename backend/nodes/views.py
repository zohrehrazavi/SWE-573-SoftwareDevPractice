from rest_framework import generics
from .serializers import NodeSerializer
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import Node, Board, ManualEdge
from django.views.decorators.http import require_GET

@login_required
def save_manual_edge(request):
    if request.method == "POST":
        from_id = request.POST.get("from")
        to_id = request.POST.get("to")
        board_id = request.POST.get("board")

        try:
            board = Board.objects.get(id=board_id, owner=request.user)
            from_node = Node.objects.get(id=from_id, board=board)
            to_node = Node.objects.get(id=to_id, board=board)
            ManualEdge.objects.get_or_create(board=board, from_node=from_node, to_node=to_node)
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

class NodeListCreateView(generics.ListCreateAPIView):
    queryset = Node.objects.all()
    serializer_class = NodeSerializer