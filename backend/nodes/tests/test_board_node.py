from django.test import TestCase
from django.contrib.auth.models import User
from django.urls import reverse
from backend.nodes.models import Board, Node, Edge, ManualEdge
import json

class BoardNodeManagementTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            username='boarduser',
            password='testpass123'
        )
        self.client.login(username='boarduser', password='testpass123')
        self.board = Board.objects.create(
            name='Test Board',
            owner=self.user
        )
        
    def test_board_creation(self):
        """Test creating a board with validation"""
        response = self.client.post(reverse('create_board'), {
            'name': 'New Board',
            'description': 'A test board'
        })
        self.assertEqual(response.status_code, 302)
        self.assertTrue(Board.objects.filter(name='New Board').exists())
        
        # Test duplicate board name
        response = self.client.post(reverse('create_board'), {
            'name': 'New Board',
            'description': 'Another board'
        })
        self.assertEqual(response.status_code, 200)  # Form validation shows error
        self.assertEqual(Board.objects.filter(name='New Board').count(), 1)  # Still only one board

    def test_node_creation(self):
        """Test creating and validating nodes"""
        response = self.client.post(reverse('node-list-create'), {
            'name': 'Test Node',
            'description': 'A test node',
            'board': self.board.id
        })
        self.assertEqual(response.status_code, 201)
        self.assertTrue(Node.objects.filter(name='Test Node').exists())

    def test_edge_creation(self):
        """Test creating edges between nodes"""
        node1 = Node.objects.create(name='Node 1', board=self.board)
        node2 = Node.objects.create(name='Node 2', board=self.board)
        
        response = self.client.post(reverse('save_manual_edge'), {
            'from': node1.id,
            'to': node2.id,
            'board': self.board.id,
            'label': 'connects to'
        })
        self.assertEqual(response.status_code, 200)
        self.assertTrue(ManualEdge.objects.filter(from_node=node1, to_node=node2).exists())

    def test_board_permissions(self):
        """Test board editor permissions"""
        other_user = User.objects.create_user(
            username='otheruser',
            password='testpass123'
        )
        
        # Test that other user can't edit the board
        self.client.login(username='otheruser', password='testpass123')
        response = self.client.post(reverse('edit_board', kwargs={'board_id': self.board.id}), {
            'name': 'Changed Name',
            'description': 'Changed description'
        })
        self.assertEqual(response.status_code, 404)  # Board not found for non-owner 