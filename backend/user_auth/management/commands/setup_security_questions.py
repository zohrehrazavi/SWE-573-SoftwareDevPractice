from django.core.management.base import BaseCommand
from backend.user_auth.models import SecurityQuestion

class Command(BaseCommand):
    help = 'Sets up the default security questions'

    def handle(self, *args, **options):
        # Create the elementary school question if it doesn't exist
        question, created = SecurityQuestion.objects.get_or_create(
            question_type='elementary_school'
        )
        
        if created:
            self.stdout.write(self.style.SUCCESS('Successfully created security question'))
        else:
            self.stdout.write(self.style.SUCCESS('Security question already exists')) 