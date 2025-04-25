from django.test import TestCase, Client
from django.contrib.auth.models import User
from django.urls import reverse
from backend.nodes.models import Board, Node
from backend.user_auth.utils import fetch_wikidata_properties_by_name
from unittest.mock import patch, MagicMock

class PropertyHandlingTestCase(TestCase):
    def setUp(self):
        # Create test user
        self.user = User.objects.create_user(
            username='testuser',
            password='testpass123'
        )
        # Create test board
        self.board = Board.objects.create(
            name='Test Board',
            owner=self.user
        )
        # Create test node
        self.node = Node.objects.create(
            name='brad pitt',
            board=self.board
        )
        # Set up client
        self.client = Client()
        self.client.login(username='testuser', password='testpass123')

    def test_manual_property_addition(self):
        """Test adding properties manually"""
        test_properties = {
            'instance_of': 'human',
            'occupation': 'television actor',
            'eye_color': 'Blue',
            'hair_type': 'dirty blond hair'
        }
        
        response = self.client.post(
            reverse('add_manual_property', args=[self.node.id]),
            test_properties
        )
        
        # Refresh node from database
        self.node.refresh_from_db()
        
        # Check if properties were saved correctly
        self.assertEqual(self.node.properties.get('instance_of'), 'human')
        self.assertEqual(self.node.properties.get('occupation'), 'television actor')
        self.assertEqual(self.node.properties.get('eye_color'), 'Blue')
        self.assertEqual(self.node.properties.get('hair_type'), 'dirty blond hair')
        
        # Check redirect
        self.assertRedirects(response, reverse('node_detail', args=[self.node.id]))

    def test_wikidata_property_fetching(self):
        """Test fetching properties from Wikidata"""
        # Mock Wikidata response
        mock_wikidata_response = {
            'entities': {
                'Q35332': {
                    'claims': {
                        'P31': [{
                            'mainsnak': {
                                'snaktype': 'value',
                                'datavalue': {'value': {'id': 'Q5'}}
                            }
                        }],
                        'P106': [{
                            'mainsnak': {
                                'snaktype': 'value',
                                'datavalue': {'value': {'id': 'Q10800557'}}
                            }
                        }],
                        'P21': [{
                            'mainsnak': {
                                'snaktype': 'value',
                                'datavalue': {'value': {'id': 'Q6581097'}}
                            }
                        }]
                    }
                }
            }
        }

        with patch('requests.get') as mock_get:
            # Mock the response for ID lookup
            mock_get.return_value.json.return_value = {
                'search': [{'id': 'Q35332'}]
            }
            mock_get.return_value.status_code = 200

            # Test fetching Wikidata properties
            response = self.client.get(
                reverse('fetch_node_properties', args=[self.node.id])
            )
            
            # Check redirect to review page
            self.assertRedirects(response, 
                reverse('review_node_properties', args=[self.node.id]))

    def test_property_approval(self):
        """Test approving fetched Wikidata properties"""
        # Simulate properties in session
        session = self.client.session
        session['suggested_properties'] = {
            'instance_of': 'human',
            'occupation': 'television actor',
            'gender': 'male'
        }
        session.save()

        # Submit property approval
        response = self.client.post(
            reverse('approve_node_properties', args=[self.node.id]),
            {
                'property_instance_of': 'human',
                'property_occupation': 'television actor',
                'property_gender': 'male'
            }
        )

        # Refresh node from database
        self.node.refresh_from_db()

        # Check if properties were saved correctly
        self.assertEqual(self.node.properties.get('instance_of'), 'human')
        self.assertEqual(self.node.properties.get('occupation'), 'television actor')
        self.assertEqual(self.node.properties.get('gender'), 'male')

        # Check redirect to node detail
        self.assertRedirects(response, reverse('node_detail', args=[self.node.id]))

    def test_property_display(self):
        """Test if properties are displayed correctly in node detail view"""
        # Set up test properties
        self.node.properties = {
            'instance_of': 'human',
            'occupation': 'television actor',
            'eye_color': 'Blue',
            'hair_type': 'dirty blond hair',
            'gender': 'male',
            'country_of_citizenship': 'United States'
        }
        self.node.save()

        # Get node detail page
        response = self.client.get(reverse('node_detail', args=[self.node.id]))

        # Check if all properties are in the response
        self.assertContains(response, 'human')
        self.assertContains(response, 'television actor')
        self.assertContains(response, 'Blue')
        self.assertContains(response, 'dirty blond hair')
        self.assertContains(response, 'male')
        self.assertContains(response, 'United States')

    def test_property_organization(self):
        """Test if properties are correctly organized into sections"""
        # Set up test properties
        self.node.properties = {
            'instance_of': 'human',
            'occupation': 'television actor',
            'eye_color': 'Blue',
            'hair_type': 'dirty blond hair',
            'gender': 'male',
            'country_of_citizenship': 'United States'
        }
        self.node.save()

        # Get node detail page
        response = self.client.get(reverse('node_detail', args=[self.node.id]))

        # Check if section headers exist
        self.assertContains(response, 'Basic Information')
        self.assertContains(response, 'Personal Details')
        self.assertContains(response, 'Physical Characteristics')

        # Check if properties are under correct sections
        content = response.content.decode()
        
        # Basic Information section should contain instance_of and occupation
        basic_info_index = content.find('Basic Information')
        personal_details_index = content.find('Personal Details')
        self.assertTrue(basic_info_index < content.find('human') < personal_details_index)
        self.assertTrue(basic_info_index < content.find('television actor') < personal_details_index)

        # Physical Characteristics section should contain eye_color and hair_type
        physical_char_index = content.find('Physical Characteristics')
        self.assertTrue(physical_char_index < content.find('Blue'))
        self.assertTrue(physical_char_index < content.find('dirty blond hair')) 