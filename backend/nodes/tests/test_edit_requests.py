from django.test import TestCase
from django.contrib.auth.models import User
from backend.nodes.models import Board, Node, EditRequest

class EditRequestTests(TestCase):
    def setUp(self):
        self.owner = User.objects.create_user(username='owner', password='testpass123')
        self.editor = User.objects.create_user(username='editor', password='testpass123')
        self.board = Board.objects.create(name='Test Board', owner=self.owner)
        self.node = Node.objects.create(name='Test Node', board=self.board)

    def test_edit_request_creation(self):
        """Test creating and validating edit requests"""
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(f'/node/{self.node.id}/request_edit/', {
            'proposed_changes': 'Update node description',
            'description': 'Adding more details'
        })
        self.assertEqual(response.status_code, 302)
        self.assertTrue(EditRequest.objects.filter(node=self.node).exists())

    def test_request_workflow(self):
        """Test the complete edit request workflow"""
        # Create request
        edit_request = EditRequest.objects.create(
            node=self.node,
            requester=self.editor,
            proposed_changes='Update content',
            description='Adding details'
        )
        
        # Test approval
        self.client.login(username='owner', password='testpass123')
        response = self.client.post(f'/edit-request/{edit_request.id}/approve/')
        self.assertEqual(response.status_code, 302)
        
        edit_request.refresh_from_db()
        self.assertEqual(edit_request.status, 'approved')

    def test_permission_checks(self):
        """Test permission checks for edit request actions"""
        edit_request = EditRequest.objects.create(
            node=self.node,
            requester=self.editor,
            proposed_changes='Update content'
        )
        
        # Test that editor can't approve their own request
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(f'/edit-request/{edit_request.id}/approve/')
        self.assertEqual(response.status_code, 403)

    def test_request_deletion(self):
        """Test edit request deletion by owner/requester"""
        edit_request = EditRequest.objects.create(
            node=self.node,
            requester=self.editor,
            proposed_changes='Update content'
        )
        
        # Test deletion by requester
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(f'/edit-request/{edit_request.id}/delete/')
        self.assertEqual(response.status_code, 302)
        self.assertFalse(EditRequest.objects.filter(id=edit_request.id).exists())

    def test_duplicate_prevention(self):
        """Test prevention of duplicate edit requests"""
        EditRequest.objects.create(
            node=self.node,
            requester=self.editor,
            proposed_changes='First request'
        )
        
        self.client.login(username='editor', password='testpass123')
        response = self.client.post(f'/node/{self.node.id}/request_edit/', {
            'proposed_changes': 'Second request'
        })
        self.assertEqual(response.status_code, 400)  # Bad request for duplicate
        self.assertEqual(EditRequest.objects.filter(node=self.node, requester=self.editor).count(), 1) 