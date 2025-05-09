# user_auth/forms.py
from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from backend.nodes.models import Board
from backend.nodes.models import Node

class NodeForm(forms.ModelForm):
    class Meta:
        model = Node
        fields = ['name', 'description']

class CustomUserCreationForm(UserCreationForm):
    age_confirmation = forms.BooleanField(
        required=True,
        label="I'm over 18 years old"
    )

    class Meta:
        model = User
        fields = ['username', 'password1', 'password2', 'age_confirmation']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.help_text = None

class BoardForm(forms.ModelForm):
    board_tags = forms.CharField(
        required=False,
        widget=forms.TextInput(attrs={
            'placeholder': 'Enter tags separated by commas (max 5 tags)',
            'class': 'tag-input'
        })
    )

    description = forms.CharField(
        required=False,
        widget=forms.Textarea(attrs={
            'placeholder': 'Enter board description (max 500 characters)',
            'class': 'board-description',
            'maxlength': '500',
            'rows': '4'
        })
    )

    class Meta:
        model = Board
        fields = ['name', 'description', 'board_tags']

    def clean_board_tags(self):
        tags_str = self.cleaned_data.get('board_tags', '').strip()
        if not tags_str:
            return []
            
        tags = [tag.strip().lower() for tag in tags_str.split(',') if tag.strip()]
        
        # Remove duplicates while preserving order
        seen = set()
        unique_tags = []
        for tag in tags:
            if tag not in seen:
                seen.add(tag)
                unique_tags.append(tag)
        
        if len(unique_tags) > 5:
            raise forms.ValidationError('Maximum 5 tags are allowed')
            
        for tag in unique_tags:
            if len(tag) > 20:
                raise forms.ValidationError(f'Tag "{tag}" is too long (maximum 20 characters)')
            
        return unique_tags

class ManualPropertyForm(forms.Form):
    # Existing general properties
    instance_of = forms.CharField(label='Instance of (Wikidata ID)', required=False)
    occupation = forms.CharField(label='Occupation (Wikidata ID)', required=False)
    gender = forms.CharField(label='Gender (Wikidata ID)', required=False)
    country_of_citizenship = forms.CharField(label='Country of Citizenship (Wikidata ID)', required=False)

    # Human-specific
    date_of_birth = forms.CharField(label='Date of Birth (Wikidata ID)', required=False)
    date_of_death = forms.CharField(label='Date of Death (Wikidata ID)', required=False)
    place_of_birth = forms.CharField(label='Place of Birth (Wikidata ID)', required=False)
    place_of_death = forms.CharField(label='Place of Death (Wikidata ID)', required=False)
    residence = forms.CharField(label='Residence (Wikidata ID)', required=False)
    family_name = forms.CharField(label='Family Name (Wikidata ID)', required=False)
    given_name = forms.CharField(label='Given Name (Wikidata ID)', required=False)
    ethnic_group = forms.CharField(label='Ethnic Group (Wikidata ID)', required=False)
    eye_color = forms.CharField(label='Eye Color (Wikidata ID)', required=False)
    hair_color = forms.CharField(label='Hair Color (Wikidata ID)', required=False)
    hair_type = forms.CharField(label='Hair Type (Wikidata ID)', required=False)

    # Case-Specific
    title = forms.CharField(label='Title (e.g., of report or testimony)', required=False)
    published_in = forms.CharField(label='Published In (e.g., newspaper)', required=False)
    name_in_native_language = forms.CharField(label='Name in Native Language', required=False)
    applies_to_part = forms.CharField(label='Applies to Part (e.g., scarf)', required=False)
    point_in_time = forms.CharField(label='Point in Time (e.g., date of report)', required=False)