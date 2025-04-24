from django.urls import path
from .views import NodeListCreateView, save_manual_edge, delete_manual_edge
from .graph_views import BoardGraphAPIView
from .views import graph_preview

urlpatterns = [
    path('nodes/', NodeListCreateView.as_view(), name='node-list-create'),
    path('board/<int:board_id>/graph/', BoardGraphAPIView.as_view(), name='board-graph'),
    path('graph_preview/<int:board_id>/', graph_preview, name='graph-preview'),
    path("edge/add/", save_manual_edge, name="save_manual_edge"),
    path("edge/delete/", delete_manual_edge, name="delete_manual_edge"),
]
