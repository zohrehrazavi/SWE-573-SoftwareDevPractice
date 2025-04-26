"""
URL configuration for project project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.urls import path, include
from django.contrib import admin
from backend.user_auth.views import (
    home_view, register, create_board, board_detail,
    create_node, node_detail, fetch_node_properties,
    add_manual_property, review_node_properties, approve_node_properties,
    delete_node, custom_logout, delete_board, edit_board
)
from django.contrib.auth import views as auth_views
from django.shortcuts import redirect

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include("backend.nodes.urls")),
    path("auth/register/", register, name="register"),
    path("home/", home_view, name="home"),
    path("auth/login/", auth_views.LoginView.as_view(template_name="registration/login.html"), name="login"),
    path("auth/logout/", custom_logout, name="logout"),
    path("board/create/", create_board, name="create_board"),
    path("board/<int:board_id>/", board_detail, name="board_detail"),
    path("board/<int:board_id>/delete/", delete_board, name="delete_board"),
    path("board/<int:board_id>/edit/", edit_board, name="edit_board"),
    path('board/<int:board_id>/node/create/', create_node, name='create_node'),
    path("node/<int:node_id>/fetch_properties/", fetch_node_properties, name="fetch_node_properties"),
    path('node/<int:node_id>/', node_detail, name='node_detail'),
    path('node/<int:node_id>/add_property/', add_manual_property, name='add_manual_property'),
    path("node/<int:node_id>/review_properties/", review_node_properties, name="review_node_properties"),
    path("node/<int:node_id>/approve_properties/", approve_node_properties, name="approve_node_properties"),
    path("node/<int:node_id>/delete/", delete_node, name="delete_node"),
    path('', lambda request: redirect('home'), name='root'),
]

