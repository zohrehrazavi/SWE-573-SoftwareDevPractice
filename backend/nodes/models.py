from django.db import models
from django.contrib.auth.models import User

class Board(models.Model):
    name = models.CharField(max_length=255)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Node(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)  # NEW
    board = models.ForeignKey(Board, on_delete=models.CASCADE, related_name='nodes')
    properties = models.JSONField(blank=True, null=True)

    def __str__(self):
        return self.name

class Edge(models.Model):
    from_node = models.ForeignKey(Node, on_delete=models.CASCADE, related_name='outgoing_edges')
    to_node = models.ForeignKey(Node, on_delete=models.CASCADE, related_name='incoming_edges')
    board = models.ForeignKey(Board, on_delete=models.CASCADE, related_name='edges')
    label = models.CharField(max_length=50, blank=True, default='')  # Add label field
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ('from_node', 'to_node', 'board')

    def __str__(self):
        return f"Edge from {self.from_node} to {self.to_node} ({self.label})"

class ManualEdge(models.Model):
    board = models.ForeignKey(Board, on_delete=models.CASCADE)
    from_node = models.ForeignKey(Node, on_delete=models.CASCADE, related_name='manual_edges_from')
    to_node = models.ForeignKey(Node, on_delete=models.CASCADE, related_name='manual_edges_to')
    label = models.CharField(max_length=50, default='')  # Adding label field with 50 char limit

    def __str__(self):
        return f"{self.from_node.name} -> {self.label} -> {self.to_node.name}"
