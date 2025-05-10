# user_auth/forms.py
from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from backend.nodes.models import Board
from backend.nodes.models import Node
from .models import SecurityQuestion, UserSecurityAnswer

class NodeForm(forms.ModelForm):
    class Meta:
        model = Node
        fields = ['name', 'description']

class CustomUserCreationForm(UserCreationForm):
    age_confirmation = forms.BooleanField(
        required=True,
        label="I'm over 18 years old",
        widget=forms.CheckboxInput(attrs={'class': 'form-check-input'})
    )
    elementary_school = forms.CharField(
        max_length=255,
        required=True,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter your elementary school name'
        })
    )

    class Meta:
        model = User
        fields = ['username', 'password1', 'password2', 'age_confirmation', 'elementary_school']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field in self.fields.values():
            field.help_text = None
            if isinstance(field.widget, forms.TextInput) or isinstance(field.widget, forms.PasswordInput):
                field.widget.attrs.update({'class': 'form-control'})

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
    # Basic Information
    instance_of = forms.CharField(label='Instance of (Wikidata ID)', required=False)
    occupation = forms.CharField(label='Occupation (Wikidata ID)', required=False)
    gender = forms.CharField(label='Gender (Wikidata ID)', required=False)
    country_of_citizenship = forms.CharField(label='Country of Citizenship (Wikidata ID)', required=False)

    # Personal Details
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

    # Report Details
    report_title = forms.CharField(label='Report Title', required=False)
    report_source = forms.CharField(label='Report Source', required=False)
    report_date = forms.DateField(label='Report Date', required=False, widget=forms.DateInput(attrs={'type': 'date'}))

    # Witness Information
    witness_name = forms.CharField(label='Witness Name', required=False)
    witness_account = forms.CharField(label='Witness Account', required=False, widget=forms.Textarea(attrs={'rows': 4}))
    statement_platform = forms.CharField(label='Statement Platform', required=False)

    # Event Information
    event_type = forms.CharField(label='Event Type', required=False)
    event_date = forms.DateField(label='Event Date', required=False, widget=forms.DateInput(attrs={'type': 'date'}))
    event_location = forms.CharField(label='Event Location', required=False)

    # Media Evidence
    media_title = forms.CharField(label='Media Title', required=False)
    media_source = forms.CharField(label='Media Source', required=False)
    media_date = forms.DateField(label='Media Date', required=False, widget=forms.DateInput(attrs={'type': 'date'}))

    # Discovery Information
    discovery_date = forms.DateField(label='Discovery Date', required=False, widget=forms.DateInput(attrs={'type': 'date'}))
    discovery_location = forms.CharField(label='Discovery Location', required=False)
    discovered_by = forms.CharField(label='Discovered By', required=False)

class PasswordResetRequestForm(forms.Form):
    username = forms.CharField(
        max_length=150,
        required=True,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    answer = forms.CharField(
        max_length=255,
        required=True,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter your elementary school name'
        })
    )

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Since we only have one question now, we can remove the dropdown
        # and just show the static question text
        self.security_question = "What was your elementary school name?"

class SetNewPasswordForm(forms.Form):
    new_password1 = forms.CharField(
        widget=forms.PasswordInput(),
        required=True,
        label="New Password"
    )
    new_password2 = forms.CharField(
        widget=forms.PasswordInput(),
        required=True,
        label="Confirm New Password"
    )

    def clean(self):
        cleaned_data = super().clean()
        password1 = cleaned_data.get('new_password1')
        password2 = cleaned_data.get('new_password2')
        
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords don't match")
        
        return cleaned_data