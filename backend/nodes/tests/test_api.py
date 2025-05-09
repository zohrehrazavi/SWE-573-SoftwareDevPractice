from django.test import TestCase
from django.contrib.auth.models import User
from rest_framework.test import APIClient
from rest_framework import status
from backend.nodes.models import Board, Node

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