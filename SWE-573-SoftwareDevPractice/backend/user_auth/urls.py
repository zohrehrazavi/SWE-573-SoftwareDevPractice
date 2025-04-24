from django.urls import path
from . import views
from django.contrib.auth import views as auth_views

urlpatterns = [
    # ... your other URL patterns ...
    path('logout/', views.custom_logout, name='logout'),  # Replace the default logout view with your custom one
] 