# nodes/tests.py
from django.test import TestCase
from django.contrib.auth.models import User
from rest_framework.test import APIClient
from rest_framework import status
from backend.nodes.models import Node

# MODEL TESTS
class NodeModelTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='testpass')
        self.board = Board.objects.create(name='Test Board', owner=self.user)
        self.node = Node.objects.create(name='Test Node', description='Test Desc', board=self.board)

    def test_node_creation(self):
        self.assertEqual(self.node.name, 'Test Node')
        self.assertEqual(self.node.board, self.board)
        self.assertEqual(str(self.node), 'Test Node')

    def test_board_creation(self):
        self.assertEqual(self.board.name, 'Test Board')
        self.assertEqual(self.board.owner, self.user)
        self.assertEqual(str(self.board), 'Test Board')

# API TESTS
class NodeAPITestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create_user(username='apitestuser', password='apitestpass')
        self.board = Board.objects.create(name='API Board', owner=self.user)

    def test_node_list_empty(self):
        response = self.client.get('/api/nodes/')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, [])  # should be empty initially

    def test_create_node(self):
        self.client.force_authenticate(user=self.user)
        payload = {
            'name': 'API Node',
            'description': 'API Desc',
            'board': self.board.id
        }
        response = self.client.post('/api/nodes/', payload, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(Node.objects.count(), 1)
        self.assertEqual(Node.objects.first().name, 'API Node')
