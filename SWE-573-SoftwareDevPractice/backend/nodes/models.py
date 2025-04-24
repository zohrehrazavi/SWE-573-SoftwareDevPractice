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

class ManualEdge(models.Model):
    board = models.ForeignKey(Board, on_delete=models.CASCADE)
    from_node = models.ForeignKey(Node, on_delete=models.CASCADE, related_name='manual_edges_from')
    to_node = models.ForeignKey(Node, on_delete=models.CASCADE, related_name='manual_edges_to')
