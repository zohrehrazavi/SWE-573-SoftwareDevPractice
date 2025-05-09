from django.test import TestCase
from django.contrib.auth.models import User
from backend.nodes.models import Board, Node, ContributionMessage

class ContributionMessageTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='messageuser', password='testpass123')
        self.other_user = User.objects.create_user(username='otheruser', password='testpass123')
        self.board = Board.objects.create(name='Message Board', owner=self.user)
        self.node = Node.objects.create(name='Message Node', board=self.board)

    def test_message_creation(self):
        """Test creating and validating messages"""
        self.client.login(username='messageuser', password='testpass123')
        response = self.client.post(f'/node/{self.node.id}/messages/', {
            'content': 'Test message content',
            'message_type': 'comment'
        })
        self.assertEqual(response.status_code, 201)
        self.assertTrue(ContributionMessage.objects.filter(node=self.node).exists())

    def test_message_length_limits(self):
        """Test message length validation"""
        self.client.login(username='messageuser', password='testpass123')
        
        # Test too long message
        response = self.client.post(f'/node/{self.node.id}/messages/', {
            'content': 'x' * 1001,  # Assuming 1000 char limit
            'message_type': 'comment'
        })
        self.assertEqual(response.status_code, 400)

    def test_message_editing(self):
        """Test message editing permissions"""
        message = ContributionMessage.objects.create(
            node=self.node,
            author=self.user,
            content='Original content'
        )
        
        # Test editing own message
        self.client.login(username='messageuser', password='testpass123')
        response = self.client.put(f'/messages/{message.id}/', {
            'content': 'Updated content'
        })
        self.assertEqual(response.status_code, 200)
        
        # Test editing someone else's message
        self.client.login(username='otheruser', password='testpass123')
        response = self.client.put(f'/messages/{message.id}/', {
            'content': 'Unauthorized update'
        })
        self.assertEqual(response.status_code, 403)

    def test_message_deletion(self):
        """Test message deletion permissions"""
        message = ContributionMessage.objects.create(
            node=self.node,
            author=self.user,
            content='Delete test'
        )
        
        # Test deleting own message
        self.client.login(username='messageuser', password='testpass123')
        response = self.client.delete(f'/messages/{message.id}/')
        self.assertEqual(response.status_code, 204)
        self.assertFalse(ContributionMessage.objects.filter(id=message.id).exists())

    def test_message_ordering(self):
        """Test message ordering by timestamp"""
        ContributionMessage.objects.create(
            node=self.node,
            author=self.user,
            content='First message'
        )
        ContributionMessage.objects.create(
            node=self.node,
            author=self.user,
            content='Second message'
        )
        
        response = self.client.get(f'/node/{self.node.id}/messages/')
        messages = response.json()
        self.assertEqual(len(messages), 2)
        self.assertTrue(messages[0]['timestamp'] > messages[1]['timestamp'])

    def test_empty_message_handling(self):
        """Test handling of empty or whitespace-only messages"""
        self.client.login(username='messageuser', password='testpass123')
        
        # Test empty message
        response = self.client.post(f'/node/{self.node.id}/messages/', {
            'content': '',
            'message_type': 'comment'
        })
        self.assertEqual(response.status_code, 400)
        
        # Test whitespace-only message
        response = self.client.post(f'/node/{self.node.id}/messages/', {
            'content': '   ',
            'message_type': 'comment'
        })
        self.assertEqual(response.status_code, 400) 