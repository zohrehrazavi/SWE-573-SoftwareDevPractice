# backend/nodes/graph_views.py

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from .models import Board, Node, ManualEdge

class BoardGraphAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, board_id):
        try:
            board = Board.objects.get(id=board_id)
        except Board.DoesNotExist:
            return Response({"error": "Board not found."}, status=404)

        nodes = board.nodes.all()
        graph_nodes = []
        edges = []

        # Add main nodes
        for node in nodes:
            graph_nodes.append({
                "id": str(node.id),
                "name": node.name,
                "description": node.description,
                "type": "main",
                "properties": node.properties or {},
                "created_by": node.created_by_id
            })

        # Add manual edges
        manual_edges = ManualEdge.objects.filter(board=board)
        for edge in manual_edges:
            edges.append({
                "from": str(edge.from_node.id),
                "to": str(edge.to_node.id),
                "label": edge.label,
                "created_by": edge.created_by_id
            })

        result = {
            "nodes": graph_nodes,
            "edges": edges
        }
        print(f"[DEBUG] BoardGraphAPIView for board {board_id}: {result}")
        return Response(result)
