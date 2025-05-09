from rest_framework import generics
from .serializers import NodeSerializer
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import Node, Board, ManualEdge, Edge, ContributionMessage
from django.views.decorators.http import require_GET, require_http_methods, require_POST
import json
from django.views.decorators.csrf import csrf_exempt, ensure_csrf_cookie
from django.utils.decorators import method_decorator
from backend.nodes.models import EditRequest, BoardEditor

def user_can_edit_board(user, board):
    return board.owner == user or BoardEditor.objects.filter(board=board, user=user).exists()

@login_required
def save_manual_edge(request):
    if request.method == "POST":
        from_id = request.POST.get("from")
        to_id = request.POST.get("to")
        board_id = request.POST.get("board")
        label = request.POST.get("label", "").strip()

        if not label:
            return JsonResponse({"status": "error", "message": "Edge label is required"}, status=400)
        
        if len(label) > 50:
            return JsonResponse({"status": "error", "message": "Edge label is too long (maximum 50 characters)"}, status=400)

        try:
            board = Board.objects.get(id=board_id)
            if not user_can_edit_board(request.user, board):
                return JsonResponse({"status": "error", "message": "Permission denied."}, status=403)
            from_node = Node.objects.get(id=from_id, board=board)
            to_node = Node.objects.get(id=to_id, board=board)
            edge, created = ManualEdge.objects.get_or_create(
                board=board, 
                from_node=from_node, 
                to_node=to_node,
                defaults={'label': label, 'created_by': request.user}
            )
            if not created:
                # Always update label and creator to current user
                edge.label = label
                edge.created_by = request.user
                edge.save()
            return JsonResponse({"status": "ok"})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=400)

@login_required
def delete_manual_edge(request):
    if request.method == "POST":
        from_id = request.POST.get("from")
        to_id = request.POST.get("to")
        board_id = request.POST.get("board")
        try:
            board = Board.objects.get(id=board_id)
        except Board.DoesNotExist:
            return JsonResponse({"status": "error", "message": "Board not found."}, status=404)
        # Find the edge
        edge = ManualEdge.objects.filter(
            board_id=board_id,
            from_node_id=from_id,
            to_node_id=to_id
        ).first()
        if not edge:
            return JsonResponse({"status": "error", "message": "Edge not found."}, status=404)
        # Only allow board owner or edge creator to delete
        if not (board.owner == request.user or edge.created_by == request.user):
            return JsonResponse({"status": "error", "message": "You do not have permission to delete this edge."}, status=403)
        edge.delete()
        return JsonResponse({"status": "deleted"})

@login_required
def graph_preview(request, board_id):
    try:
        board = Board.objects.get(id=board_id, owner=request.user)
    except Board.DoesNotExist:
        return render(request, "not_found.html", {"message": "Board not found."})

    return render(request, "graph.html", {"board_id": board.id})

@require_http_methods(["POST"])
def create_manual_edge(request):
    try:
        data = json.loads(request.body)
        from_node_id = data.get('from_node_id')
        to_node_id = data.get('to_node_id')
        board_id = data.get('board_id')
        label = data.get('label', '')
        if not all([from_node_id, to_node_id, board_id]):
            return JsonResponse({'status': 'error', 'message': 'Missing required fields'}, status=400)
        board = Board.objects.get(id=board_id)
        if not user_can_edit_board(request.user, board):
            return JsonResponse({'status': 'error', 'message': 'Permission denied.'}, status=403)
        from_node = Node.objects.get(id=from_node_id, board=board)
        to_node = Node.objects.get(id=to_node_id, board=board)
        if Edge.objects.filter(from_node=from_node, to_node=to_node, board=board).exists():
            return JsonResponse({'status': 'error', 'message': 'Edge already exists'}, status=400)
        edge = Edge.objects.create(
            from_node=from_node,
            to_node=to_node,
            board=board,
            label=label
        )
        return JsonResponse({'status': 'success', 'message': 'Edge created successfully'})
    except Board.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Board not found'}, status=404)
    except Node.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Node not found'}, status=404)
    except json.JSONDecodeError:
        return JsonResponse({'status': 'error', 'message': 'Invalid JSON'}, status=400)
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': str(e)}, status=500)

class NodeListCreateView(generics.ListCreateAPIView):
    queryset = Node.objects.all()
    serializer_class = NodeSerializer

@csrf_exempt
@login_required
@require_http_methods(["POST"])
def request_edit_access(request, board_id):
    import json
    data = json.loads(request.body.decode('utf-8'))
    message = data.get('message', '')
    board = Board.objects.get(id=board_id)
    # Prevent duplicate pending requests from the same user
    if EditRequest.objects.filter(board=board, sender=request.user, status='pending').exists():
        return JsonResponse({'status': 'error', 'message': 'You already have a pending request.'}, status=400)
    EditRequest.objects.create(board=board, sender=request.user, message=message)
    return JsonResponse({'status': 'ok'})

@login_required
@require_http_methods(["GET"])
def get_edit_requests(request):
    # Get all pending requests for boards owned by the user
    requests = EditRequest.objects.filter(board__owner=request.user, status='pending').select_related('board', 'sender').order_by('-created_at')
    data = [
        {
            'id': r.id,
            'board_id': r.board.id,
            'board_name': r.board.name,
            'sender': r.sender.username,
            'message': r.message,
            'created_at': r.created_at.strftime('%Y-%m-%d %H:%M'),
            'status': r.status,
        }
        for r in requests
    ]
    return JsonResponse({'requests': data})

@login_required
@require_POST
def edit_request_action(request, request_id):
    import json
    try:
        req = EditRequest.objects.select_related('board').get(id=request_id)
        if req.board.owner != request.user:
            return JsonResponse({'status': 'error', 'message': 'Permission denied.'}, status=403)
        data = json.loads(request.body.decode('utf-8'))
        action = data.get('action')
        if action not in ['accept', 'deny']:
            return JsonResponse({'status': 'error', 'message': 'Invalid action.'}, status=400)
        req.status = 'accepted' if action == 'accept' else 'denied'
        req.save()
        if action == 'accept':
            BoardEditor.objects.get_or_create(board=req.board, user=req.sender)
        return JsonResponse({'status': 'ok'})
    except EditRequest.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Request not found.'}, status=404)

@login_required
@require_GET
def my_edit_requests(request):
    # For the logged-in user, return their edit requests (pending, accepted, denied)
    requests = EditRequest.objects.filter(sender=request.user).select_related('board').order_by('-created_at')
    data = [
        {
            'id': r.id,
            'board_id': r.board.id,
            'board_name': r.board.name,
            'status': r.status,
            'created_at': r.created_at.strftime('%Y-%m-%d %H:%M'),
            'read_by_sender': r.read_by_sender,
        }
        for r in requests
    ]
    return JsonResponse({'requests': data})

@login_required
@require_http_methods(["DELETE"])
def delete_edit_request(request, request_id):
    try:
        req = EditRequest.objects.select_related('board').get(id=request_id)
        if req.sender != request.user and req.board.owner != request.user:
            return JsonResponse({'status': 'error', 'message': 'Permission denied.'}, status=403)
        req.delete()
        return JsonResponse({'status': 'deleted'})
    except EditRequest.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Request not found.'}, status=404)

@login_required
@require_http_methods(["POST"])
def mark_edit_request_read(request, request_id):
    try:
        req = EditRequest.objects.get(id=request_id, sender=request.user)
        req.read_by_sender = True
        req.save()
        return JsonResponse({'status': 'ok'})
    except EditRequest.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Request not found.'}, status=404)

@login_required
@require_http_methods(["POST"])
def post_message(request, board_id):
    content = request.POST.get("content", "").strip()
    if not content:
        return JsonResponse({"error": "Empty message"}, status=400)
    board = get_object_or_404(Board, id=board_id)
    msg = ContributionMessage.objects.create(board=board, user=request.user, content=content)
    return JsonResponse({
        "id": msg.id,
        "user": request.user.username,
        "content": msg.content,
        "created_at": msg.created_at.strftime("%Y-%m-%d %H:%M"),
    })

@login_required
@require_http_methods(["POST"])
def edit_message(request, message_id):
    msg = get_object_or_404(ContributionMessage, id=message_id)
    if msg.user != request.user:
        return JsonResponse({"error": "Permission denied"}, status=403)
    content = request.POST.get("content", "").strip()
    if not content:
        return JsonResponse({"error": "Empty message"}, status=400)
    msg.content = content
    msg.save()
    return JsonResponse({"success": True, "content": msg.content})

@login_required
@require_http_methods(["POST"])
def delete_message(request, message_id):
    msg = get_object_or_404(ContributionMessage, id=message_id)
    if msg.user != request.user:
        return JsonResponse({"error": "Permission denied"}, status=403)
    msg.delete()
    return JsonResponse({"success": True})

@login_required
def update_edge_label(request):
    if request.method == "POST":
        from_id = request.POST.get("from")
        to_id = request.POST.get("to")
        board_id = request.POST.get("board")
        new_label = request.POST.get("label", "").strip()

        if not new_label:
            return JsonResponse({"status": "error", "message": "Edge label is required"}, status=400)
        
        if len(new_label) > 50:
            return JsonResponse({"status": "error", "message": "Edge label is too long (maximum 50 characters)"}, status=400)

        try:
            edge = ManualEdge.objects.get(
                board_id=board_id,
                from_node_id=from_id,
                to_node_id=to_id
            )
            
            # Check if user has permission to edit this edge
            if edge.created_by != request.user and edge.board.owner != request.user:
                return JsonResponse({"status": "error", "message": "You don't have permission to edit this edge"}, status=403)
            
            edge.label = new_label
            edge.save()
            
            return JsonResponse({"status": "ok", "message": "Edge label updated successfully"})
        except ManualEdge.DoesNotExist:
            return JsonResponse({"status": "error", "message": "Edge not found"}, status=404)
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=400)