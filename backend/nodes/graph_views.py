# backend/nodes/graph_views.py

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from nodes.models import Board, Node
from collections import defaultdict

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
        property_to_nodes = defaultdict(list)

        # Add main nodes and track properties
        for node in nodes:
            graph_nodes.append({"id": node.name, "type": "main"})

            if node.properties:
                for key, value in node.properties.items():
                    prop_label = f"{value}"  # Optional: include key like f"{key}: {value}"
                    property_to_nodes[prop_label].append(node.name)

        # Add property nodes and edges
        for prop, node_names in property_to_nodes.items():
            graph_nodes.append({"id": prop, "type": "property"})
            for node_name in node_names:
                edges.append({"from": node_name, "to": prop})

        # Shared properties = more than 1 node linked to the same property
        shared_properties = {prop: names for prop, names in property_to_nodes.items() if len(names) > 1}

        return Response({
            "nodes": graph_nodes,
            "edges": edges,
            "shared_properties": shared_properties
        })
