# backend/nodes/graph_views.py

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from backend.nodes.models import Board, Node, ManualEdge

class BoardGraphAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, board_id):
        try:
            board = Board.objects.get(id=board_id, owner=request.user)
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
                "type": "main",
                "properties": node.properties or {}
            })

        # Add manual edges
        manual_edges = ManualEdge.objects.filter(board=board)
        for edge in manual_edges:
            edges.append({
                "from": str(edge.from_node.id),
                "to": str(edge.to_node.id)
            })

        return Response({
            "nodes": graph_nodes,
            "edges": edges
        })
