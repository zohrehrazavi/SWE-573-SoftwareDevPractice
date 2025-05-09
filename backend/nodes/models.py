from django.db import models
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError

def validate_tags(value):
    if not isinstance(value, list):
        raise ValidationError('Tags must be a list')
    if len(value) > 5:
        raise ValidationError('Maximum 5 tags are allowed')
    for tag in value:
        if not isinstance(tag, str):
            raise ValidationError('Tags must be strings')
        if len(tag) > 20:
            raise ValidationError('Tag length cannot exceed 20 characters')
        if not tag.strip():
            raise ValidationError('Empty tags are not allowed')

class Board(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(max_length=500, blank=True, null=True)  # New field
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    board_tags = models.JSONField(default=list, validators=[validate_tags], blank=True)

    def __str__(self):
        return self.name

class Node(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True, null=True)  # NEW
    board = models.ForeignKey(Board, on_delete=models.CASCADE, related_name='nodes')
    properties = models.JSONField(blank=True, null=True)
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='created_nodes')

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
    created_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True, related_name='created_manual_edges')

    def __str__(self):
        return f"{self.from_node.name} -> {self.label} -> {self.to_node.name}"

class EditRequest(models.Model):
    board = models.ForeignKey(Board, on_delete=models.CASCADE, related_name='edit_requests')
    sender = models.ForeignKey(User, on_delete=models.CASCADE, related_name='sent_edit_requests')
    message = models.TextField(blank=True)
    status = models.CharField(max_length=16, choices=[('pending', 'Pending'), ('accepted', 'Accepted'), ('denied', 'Denied')], default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    read_by_sender = models.BooleanField(default=False)

    def __str__(self):
        return f"EditRequest from {self.sender.username} for {self.board.name} ({self.status})"

class BoardEditor(models.Model):
    board = models.ForeignKey(Board, on_delete=models.CASCADE, related_name='editors')
    user = models.ForeignKey('auth.User', on_delete=models.CASCADE)
    added_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('board', 'user')

class ContributionMessage(models.Model):
    board = models.ForeignKey(Board, on_delete=models.CASCADE, related_name='contribution_messages')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.user.username}: {self.content[:30]}"
