from django.urls import path
from . import views
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('login/', views.login_view, name='login'),
    path('register/', views.register, name='register'),
    path('logout/', views.custom_logout_view, name='logout'),
    path('password-reset/', views.password_reset_request, name='password_reset_request'),
    path('password-reset/confirm/', views.password_reset_confirm, name='password_reset_confirm'),
    path('board/<int:board_id>/delete/', views.delete_board, name='delete_board'),
    path('board/create/', views.create_board, name='create_board'),
    path('board/<int:board_id>/edit/', views.edit_board, name='edit_board'),
    path('board/<int:board_id>/', views.board_detail, name='board_detail'),
    path('api/boards/<int:board_id>/update_description/', views.update_board_description, name='update_board_description'),
    path('', views.home_view, name='home'),
] 