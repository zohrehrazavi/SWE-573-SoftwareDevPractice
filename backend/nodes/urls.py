from django.urls import path
from .views import NodeListCreateView, save_manual_edge, delete_manual_edge, request_edit_access, get_edit_requests, edit_request_action, my_edit_requests, delete_edit_request, mark_edit_request_read
from .graph_views import BoardGraphAPIView

urlpatterns = [
    path('nodes/', NodeListCreateView.as_view(), name='node-list-create'),
    path('board/<int:board_id>/graph/', BoardGraphAPIView.as_view(), name='board-graph'),
    path("edge/add/", save_manual_edge, name="save_manual_edge"),
    path("edge/delete/", delete_manual_edge, name="delete_manual_edge"),
    path('board/<int:board_id>/request_edit/', request_edit_access, name='request-edit-access'),
    path('edit_requests/', get_edit_requests, name='get-edit-requests'),
    path('edit_requests/<int:request_id>/action/', edit_request_action, name='edit-request-action'),
    path('my_edit_requests/', my_edit_requests, name='my-edit-requests'),
    path('edit_request/<int:request_id>/delete/', delete_edit_request, name='delete_edit_request'),
    path('edit_request/<int:request_id>/mark_read/', mark_edit_request_read, name='mark_edit_request_read'),
]
