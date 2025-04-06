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
from django.contrib import admin
from django.urls import path, include
from user_auth.views import home_view
from user_auth.views import register
from django.contrib import admin
from django.urls import path
from user_auth.views import create_board
from user_auth.views import board_detail
from user_auth.views import create_node
from user_auth.views import node_detail, fetch_node_properties
from user_auth.views import add_manual_property
from user_auth.views import review_node_properties, approve_node_properties
from user_auth.views import delete_node

urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/", include("nodes.urls")),
    path("auth/register/", register, name="register"),
    path("auth/", include("django.contrib.auth.urls")),
    path("home/", home_view, name="home"),
    path("board/create/", create_board, name="create_board"),
    path("board/<int:board_id>/", board_detail, name="board_detail"),
    path('board/<int:board_id>/node/create/', create_node, name='create_node'),
    path("node/<int:node_id>/fetch_properties/", fetch_node_properties, name="fetch_node_properties"),
    path('node/<int:node_id>/', node_detail, name='node_detail'),
    path('node/<int:node_id>/add_property/', add_manual_property, name='add_manual_property'),
    path("node/<int:node_id>/review_properties/", review_node_properties, name="review_node_properties"),
    path("node/<int:node_id>/approve_properties/", approve_node_properties, name="approve_node_properties"),
    path('', include('nodes.urls')),
    path("node/<int:node_id>/delete/", delete_node, name="delete_node"),



]
