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
        response = self.client.post(f'/api/board/{self.board.id}/post_message/', {
            'content': 'Test message content'
        })
        self.assertEqual(response.status_code, 200)
        self.assertTrue(ContributionMessage.objects.filter(board=self.board, user=self.user, content='Test message content').exists())

    def test_message_length_limits(self):
        """Test message length validation"""
        self.client.login(username='messageuser', password='testpass123')
        # Test too long message
        response = self.client.post(f'/api/board/{self.board.id}/post_message/', {
            'content': 'x' * 1001
        })
        self.assertEqual(response.status_code, 400)

    def test_message_editing(self):
        """Test message editing permissions"""
        message = ContributionMessage.objects.create(
            board=self.board,
            user=self.user,
            content='Original content'
        )
        # Test editing own message
        self.client.login(username='messageuser', password='testpass123')
        response = self.client.post(f'/api/messages/{message.id}/edit/', {
            'content': 'Updated content'
        })
        self.assertEqual(response.status_code, 200)
        # Test editing someone else's message
        self.client.login(username='otheruser', password='testpass123')
        response = self.client.post(f'/api/messages/{message.id}/edit/', {
            'content': 'Unauthorized update'
        })
        self.assertEqual(response.status_code, 403)

    def test_message_deletion(self):
        """Test message deletion permissions"""
        message = ContributionMessage.objects.create(
            board=self.board,
            user=self.user,
            content='Delete test'
        )
        # Test deleting own message
        self.client.login(username='messageuser', password='testpass123')
        response = self.client.post(f'/api/messages/{message.id}/delete/')
        self.assertEqual(response.status_code, 200)
        self.assertFalse(ContributionMessage.objects.filter(id=message.id).exists())

    def test_message_ordering(self):
        """Test message ordering by timestamp"""
        msg1 = ContributionMessage.objects.create(
            board=self.board,
            user=self.user,
            content='First message'
        )
        msg2 = ContributionMessage.objects.create(
            board=self.board,
            user=self.user,
            content='Second message'
        )
        messages = list(ContributionMessage.objects.filter(board=self.board).order_by('-created_at'))
        self.assertEqual(len(messages), 2)
        self.assertTrue(messages[0].created_at >= messages[1].created_at)

    def test_empty_message_handling(self):
        """Test handling of empty or whitespace-only messages"""
        self.client.login(username='messageuser', password='testpass123')
        # Test empty message
        response = self.client.post(f'/api/board/{self.board.id}/post_message/', {
            'content': ''
        })
        self.assertEqual(response.status_code, 400)
        # Test whitespace-only message
        response = self.client.post(f'/api/board/{self.board.id}/post_message/', {
            'content': '   '
        })
        self.assertEqual(response.status_code, 400) 