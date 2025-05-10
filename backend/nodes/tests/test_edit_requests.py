from django.test import TestCase
from django.contrib.auth.models import User
from backend.nodes.models import Board, Node, EditRequest
import json

class EditRequestTests(TestCase):
    def setUp(self):
        self.owner = User.objects.create_user(username='owner', password='testpass123')
        self.editor = User.objects.create_user(username='editor', password='testpass123')
        self.board = Board.objects.create(name='Test Board', owner=self.owner)
        self.node = Node.objects.create(name='Test Node', board=self.board)

    def test_edit_request_creation(self):
        """Test creating and validating edit requests"""
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(
            f'/api/board/{self.board.id}/request_edit/',
            data=json.dumps({'message': 'Update node description. Adding more details.'}),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 200)
        self.assertTrue(EditRequest.objects.filter(board=self.board, sender=self.editor).exists())

    def test_request_workflow(self):
        """Test the complete edit request workflow"""
        # Create request
        edit_request = EditRequest.objects.create(
            board=self.board,
            sender=self.editor,
            message='Update content. Adding details.'
        )
        
        # Test approval
        self.client.login(username='owner', password='testpass123')
        response = self.client.post(f'/api/edit_requests/{edit_request.id}/action/', {
            'action': 'accept'
        }, content_type='application/json')
        self.assertEqual(response.status_code, 200)
        
        edit_request.refresh_from_db()
        self.assertEqual(edit_request.status, 'accepted')

    def test_permission_checks(self):
        """Test permission checks for edit request actions"""
        edit_request = EditRequest.objects.create(
            board=self.board,
            sender=self.editor,
            message='Update content'
        )
        
        # Test that editor can't approve their own request
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(f'/api/edit_requests/{edit_request.id}/action/', {
            'action': 'accept'
        }, content_type='application/json')
        self.assertEqual(response.status_code, 403)

    def test_request_deletion(self):
        """Test edit request deletion by owner/requester"""
        edit_request = EditRequest.objects.create(
            board=self.board,
            sender=self.editor,
            message='Update content'
        )
        
        # Test deletion by requester
        self.client.login(username='editor', password='testpass123')
        response = self.client.delete(f'/api/edit_request/{edit_request.id}/delete/')
        self.assertEqual(response.status_code, 200)
        self.assertFalse(EditRequest.objects.filter(id=edit_request.id).exists())

    def test_duplicate_prevention(self):
        """Test prevention of duplicate edit requests"""
        EditRequest.objects.create(
            board=self.board,
            sender=self.editor,
            message='First request'
        )
        
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(
            f'/api/board/{self.board.id}/request_edit/',
            data=json.dumps({'message': 'Second request'}),
            content_type='application/json'
        )
        self.assertEqual(response.status_code, 400)  # Bad request for duplicate
        self.assertEqual(EditRequest.objects.filter(board=self.board, sender=self.editor).count(), 1) 