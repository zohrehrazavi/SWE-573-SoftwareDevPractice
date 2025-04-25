from django.urls import path
from .views import NodeListCreateView, save_manual_edge, delete_manual_edge
from .graph_views import BoardGraphAPIView

urlpatterns = [
    path('nodes/', NodeListCreateView.as_view(), name='node-list-create'),
    path('board/<int:board_id>/graph/', BoardGraphAPIView.as_view(), name='board-graph'),
    path("edge/add/", save_manual_edge, name="save_manual_edge"),
    path("edge/delete/", delete_manual_edge, name="delete_manual_edge"),
]
