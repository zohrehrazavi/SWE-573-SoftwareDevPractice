from django.test import TestCase
from django.contrib.auth.models import User
from django.urls import reverse
from backend.user_auth.forms import BoardForm, NodeForm, CustomUserCreationForm, ManualPropertyForm
from backend.nodes.models import Board, Node
from unittest.mock import patch

class AddManualPropertyViewTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='manualtestuser', password='testpass')
        self.board = Board.objects.create(name='Manual Test Board', owner=self.user)
        self.node = Node.objects.create(name='Manual Node', board=self.board)

    def test_add_manual_property_get_view(self):
        self.client.login(username='manualtestuser', password='testpass')
        response = self.client.get(f'/node/{self.node.id}/add_property/')
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Instance of')  # Form label is rendered

    def test_add_manual_property_post_view(self):
        self.client.login(username='manualtestuser', password='testpass')
        post_data = {
            'instance_of': 'Q5',
            'occupation': 'Q937857',
            'gender': 'Q6581072',
            'country_of_citizenship': 'Q183'
        }
        response = self.client.post(f'/node/{self.node.id}/add_property/', post_data)

        self.node.refresh_from_db()
        self.assertEqual(self.node.properties['instance of'], 'Q5')
        self.assertEqual(self.node.properties['occupation'], 'Q937857')
        self.assertEqual(self.node.properties['gender'], 'Q6581072')
        self.assertEqual(self.node.properties['country of citizenship'], 'Q183')
        self.assertRedirects(response, f'/node/{self.node.id}/')

class FetchNodePropertiesTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='wikidatauser', password='testpass')
        self.board = Board.objects.create(name='Test Board', owner=self.user)
        self.node = Node.objects.create(name='Ada Lovelace', board=self.board)

    @patch('user_auth.utils.fetch_wikidata_properties_by_name')
    def test_fetch_node_properties_enrichment(self, mock_fetch):
        # Simulate mocked Wikidata response
        mock_fetch.return_value = ("Q7259", {
            "instance of": "Q5",
            "occupation": "Q937857"
        })

        self.client.login(username='wikidatauser', password='testpass')
        response = self.client.get(f'/node/{self.node.id}/fetch_properties/')

        # Refresh node from DB
        self.node.refresh_from_db()

        self.assertRedirects(response, f'/node/{self.node.id}/')
        self.assertIn('occupation', self.node.properties)
        self.assertEqual(self.node.properties['instance of'], 'Q5')

class AuthViewAccessTestCase(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='authuser', password='testpass')
        self.board = Board.objects.create(name='Test Board', owner=self.user)

    def test_home_requires_login(self):
        response = self.client.get('/home/')
        self.assertNotEqual(response.status_code, 200)
        self.assertRedirects(response, '/auth/login/?next=/home/')

    def test_home_view_authenticated(self):
        self.client.login(username='authuser', password='testpass')
        response = self.client.get('/home/')
        self.assertEqual(response.status_code, 200)

    def test_board_create_requires_login(self):
        response = self.client.get('/board/create/')
        self.assertRedirects(response, '/auth/login/?next=/board/create/')

    def test_board_create_view_authenticated(self):
        self.client.login(username='authuser', password='testpass')
        response = self.client.get('/board/create/')
        self.assertEqual(response.status_code, 200)


class BoardFormTestCase(TestCase):
    def test_valid_board_form(self):
        form = BoardForm(data={'name': 'My Board'})
        self.assertTrue(form.is_valid())

    def test_invalid_board_form(self):
        form = BoardForm(data={})
        self.assertFalse(form.is_valid())


class NodeFormTestCase(TestCase):
    def test_valid_node_form(self):
        form = NodeForm(data={'name': 'Test Node', 'description': 'A test description'})
        self.assertTrue(form.is_valid())

    def test_invalid_node_form(self):
        form = NodeForm(data={})
        self.assertFalse(form.is_valid())


class CustomUserCreationFormTestCase(TestCase):
    def test_valid_user_creation_form(self):
        form = CustomUserCreationForm(data={
            'username': 'newuser',
            'password1': 'StrongPassword123',
            'password2': 'StrongPassword123',
            'age_confirmation': True
        })
        self.assertTrue(form.is_valid())

    def test_invalid_user_creation_form(self):
        form = CustomUserCreationForm(data={
            'username': '',
            'password1': '123',
            'password2': '123',
            'age_confirmation': False
        })
        self.assertFalse(form.is_valid())


class ManualPropertyFormTestCase(TestCase):
    def test_manual_property_form_valid(self):
        form = ManualPropertyForm(data={
            'instance_of': 'Q5',
            'occupation': 'Q937857',
            'gender': 'Q6581072',
            'country_of_citizenship': 'Q183'
        })
        self.assertTrue(form.is_valid())

    def test_manual_property_form_empty(self):
        form = ManualPropertyForm(data={})
        self.assertTrue(form.is_valid())  # All fields are optional
