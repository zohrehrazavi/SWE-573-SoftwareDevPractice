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
            # Basic Information
            'instance_of': 'human',
            'occupation': 'television actor',
            'eye_color': 'Blue',
            'hair_type': 'dirty blond hair',
            
            # Report Details
            'report_title': 'Initial Investigation Report',
            'report_source': 'Local Police Department',
            'report_date': '2024-03-15',
            
            # Witness Information
            'witness_name': 'John Smith',
            'witness_account': 'I saw the suspect enter the building at approximately 2:30 PM.',
            'statement_platform': 'Police Interview',
            
            # Event Information
            'event_type': 'Suspicious Activity',
            'event_date': '2024-03-14',
            'event_location': '123 Main Street',
            
            # Media Evidence
            'media_title': 'Security Camera Footage',
            'media_source': 'Building Surveillance System',
            'media_date': '2024-03-14',
            
            # Discovery Information
            'discovery_date': '2024-03-15',
            'discovery_location': 'Parking Lot B',
            'discovered_by': 'Officer Jane Doe'
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
        
        # Check Report Details
        self.assertEqual(self.node.properties.get('report_title'), 'Initial Investigation Report')
        self.assertEqual(self.node.properties.get('report_source'), 'Local Police Department')
        self.assertEqual(self.node.properties.get('report_date'), '2024-03-15')
        
        # Check Witness Information
        self.assertEqual(self.node.properties.get('witness_name'), 'John Smith')
        self.assertEqual(self.node.properties.get('witness_account'), 'I saw the suspect enter the building at approximately 2:30 PM.')
        self.assertEqual(self.node.properties.get('statement_platform'), 'Police Interview')
        
        # Check Event Information
        self.assertEqual(self.node.properties.get('event_type'), 'Suspicious Activity')
        self.assertEqual(self.node.properties.get('event_date'), '2024-03-14')
        self.assertEqual(self.node.properties.get('event_location'), '123 Main Street')
        
        # Check Media Evidence
        self.assertEqual(self.node.properties.get('media_title'), 'Security Camera Footage')
        self.assertEqual(self.node.properties.get('media_source'), 'Building Surveillance System')
        self.assertEqual(self.node.properties.get('media_date'), '2024-03-14')
        
        # Check Discovery Information
        self.assertEqual(self.node.properties.get('discovery_date'), '2024-03-15')
        self.assertEqual(self.node.properties.get('discovery_location'), 'Parking Lot B')
        self.assertEqual(self.node.properties.get('discovered_by'), 'Officer Jane Doe')
        
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
            # Basic Information
            'instance_of': 'human',
            'occupation': 'television actor',
            'gender': 'male',
            
            # Report Details
            'report_title': 'Initial Investigation Report',
            'report_source': 'Local Police Department',
            'report_date': '2024-03-15',
            
            # Witness Information
            'witness_name': 'John Smith',
            'witness_account': 'I saw the suspect enter the building at approximately 2:30 PM.',
            'statement_platform': 'Police Interview',
            
            # Event Information
            'event_type': 'Suspicious Activity',
            'event_date': '2024-03-14',
            'event_location': '123 Main Street',
            
            # Media Evidence
            'media_title': 'Security Camera Footage',
            'media_source': 'Building Surveillance System',
            'media_date': '2024-03-14',
            
            # Discovery Information
            'discovery_date': '2024-03-15',
            'discovery_location': 'Parking Lot B',
            'discovered_by': 'Officer Jane Doe'
        }
        session.save()

        # Submit property approval
        response = self.client.post(
            reverse('approve_node_properties', args=[self.node.id]),
            {
                'property_instance_of': 'human',
                'property_occupation': 'television actor',
                'property_gender': 'male',
                'property_report_title': 'Initial Investigation Report',
                'property_report_source': 'Local Police Department',
                'property_report_date': '2024-03-15',
                'property_witness_name': 'John Smith',
                'property_witness_account': 'I saw the suspect enter the building at approximately 2:30 PM.',
                'property_statement_platform': 'Police Interview',
                'property_event_type': 'Suspicious Activity',
                'property_event_date': '2024-03-14',
                'property_event_location': '123 Main Street',
                'property_media_title': 'Security Camera Footage',
                'property_media_source': 'Building Surveillance System',
                'property_media_date': '2024-03-14',
                'property_discovery_date': '2024-03-15',
                'property_discovery_location': 'Parking Lot B',
                'property_discovered_by': 'Officer Jane Doe'
            }
        )

        # Refresh node from database
        self.node.refresh_from_db()

        # Check if properties were saved correctly
        self.assertEqual(self.node.properties.get('instance_of'), 'human')
        self.assertEqual(self.node.properties.get('occupation'), 'television actor')
        self.assertEqual(self.node.properties.get('gender'), 'male')
        
        # Check Report Details
        self.assertEqual(self.node.properties.get('report_title'), 'Initial Investigation Report')
        self.assertEqual(self.node.properties.get('report_source'), 'Local Police Department')
        self.assertEqual(self.node.properties.get('report_date'), '2024-03-15')
        
        # Check Witness Information
        self.assertEqual(self.node.properties.get('witness_name'), 'John Smith')
        self.assertEqual(self.node.properties.get('witness_account'), 'I saw the suspect enter the building at approximately 2:30 PM.')
        self.assertEqual(self.node.properties.get('statement_platform'), 'Police Interview')
        
        # Check Event Information
        self.assertEqual(self.node.properties.get('event_type'), 'Suspicious Activity')
        self.assertEqual(self.node.properties.get('event_date'), '2024-03-14')
        self.assertEqual(self.node.properties.get('event_location'), '123 Main Street')
        
        # Check Media Evidence
        self.assertEqual(self.node.properties.get('media_title'), 'Security Camera Footage')
        self.assertEqual(self.node.properties.get('media_source'), 'Building Surveillance System')
        self.assertEqual(self.node.properties.get('media_date'), '2024-03-14')
        
        # Check Discovery Information
        self.assertEqual(self.node.properties.get('discovery_date'), '2024-03-15')
        self.assertEqual(self.node.properties.get('discovery_location'), 'Parking Lot B')
        self.assertEqual(self.node.properties.get('discovered_by'), 'Officer Jane Doe')

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

    def test_add_property_form_renders_all_fields(self):
        """Test that the add property form renders all new investigative fields"""
        response = self.client.get(
            reverse('add_manual_property', args=[self.node.id])
        )
        self.assertEqual(response.status_code, 200)
        # Check for new investigative field labels
        expected_labels = [
            'Report Title', 'Report Source', 'Report Date',
            'Witness Name', 'Witness Account', 'Statement Platform',
            'Event Type', 'Event Date', 'Event Location',
            'Media Title', 'Media Source', 'Media Date',
            'Discovery Date', 'Discovery Location', 'Discovered By'
        ]
        for label in expected_labels:
            self.assertIn(label, response.content.decode())

    def test_edit_node_name_and_description(self):
        """Test editing a node's name and description via the edit_node view"""
        # Edit node
        response = self.client.get(reverse('edit_node', args=[self.node.id]))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Edit Node')
        # Post new name and description
        new_data = {'name': 'Updated Node Name', 'description': 'Updated node description.'}
        response = self.client.post(reverse('edit_node', args=[self.node.id]), new_data)
        self.assertRedirects(response, reverse('node_detail', args=[self.node.id]))
        # Check changes on detail page
        response = self.client.get(reverse('node_detail', args=[self.node.id]))
        self.assertContains(response, 'Updated Node Name')
        self.assertContains(response, 'Updated node description.') 