from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class SecurityQuestion(models.Model):
    QUESTIONS = [
        ('elementary_school', 'What was your elementary school name?'),
    ]
    
    question_type = models.CharField(max_length=50, choices=QUESTIONS, unique=True)
    
    def __str__(self):
        return dict(self.QUESTIONS)[self.question_type]

class UserSecurityAnswer(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='security_answers')
    question = models.ForeignKey(SecurityQuestion, on_delete=models.CASCADE)
    answer = models.CharField(max_length=255)
    
    class Meta:
        unique_together = ['user', 'question']
    
    def __str__(self):
        return f"{self.user.username} - {self.question}"
