from django.test import TestCase
from django.contrib.auth.models import User
from django.urls import reverse
from backend.user_auth.models import SecurityQuestion, UserSecurityAnswer

class SecurityQuestionsTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(
            username='securityuser',
            password='testpass123'
        )
        self.security_question = SecurityQuestion.objects.create(
            question_type='elementary_school'
        )
        
    def test_security_question_creation(self):
        """Test creating security questions during registration"""
        registration_data = {
            'username': 'newuser',
            'password1': 'StrongPass123',
            'password2': 'StrongPass123',
            'age_confirmation': True,
            'elementary_school': 'Test Elementary School'
        }
        response = self.client.post(reverse('register'), registration_data)
        self.assertEqual(response.status_code, 302)
        user = User.objects.get(username='newuser')
        self.assertTrue(UserSecurityAnswer.objects.filter(user=user).exists())

    def test_password_reset_with_security_questions(self):
        """Test password reset flow with security questions"""
        # Create security answer for the user
        UserSecurityAnswer.objects.create(
            user=self.user,
            question=self.security_question,
            answer='test elementary school'  # lowercase to match storage
        )
        
        # Test password reset initiation
        reset_data = {
            'username': 'securityuser',
            'answer': 'Test Elementary School'  # Should be case-insensitive
        }
        response = self.client.post(reverse('password_reset_request'), reset_data)
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, reverse('password_reset_confirm'))

        # Test setting new password
        confirm_data = {
            'new_password1': 'NewStrongPass123',
            'new_password2': 'NewStrongPass123'
        }
        response = self.client.post(reverse('password_reset_confirm'), confirm_data)
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, reverse('login'))

    def test_case_insensitive_answers(self):
        """Test that security question answers are case-insensitive"""
        UserSecurityAnswer.objects.create(
            user=self.user,
            question=self.security_question,
            answer='test elementary school'  # lowercase to match storage
        )
        
        reset_data = {
            'username': 'securityuser',
            'answer': 'TEST ELEMENTARY SCHOOL'  # Should be case-insensitive
        }
        response = self.client.post(reverse('password_reset_request'), reset_data)
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, reverse('password_reset_confirm')) 