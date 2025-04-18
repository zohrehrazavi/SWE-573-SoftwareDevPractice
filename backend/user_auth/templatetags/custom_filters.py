# user_auth/templatetags/custom_filters.py

from django import template

register = template.Library()

@register.filter
def get_item(dictionary, key):
    return dictionary.get(key)

@register.filter
def strip_label(label):
    """
    Removes text in parentheses and lowercases the result.
    """
    return label.split(" (")[0].strip().lower()

