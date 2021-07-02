import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Comments with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<CommentModel> _comments = [];
  final Map<String, List<CommentModel>> _parentIdToSubComments = {};
  String _token;

  Comments.empty();

  List<CommentModel> get comments {
    return [..._comments];
  }

  List<CommentModel> get parentComments {
    return _comments.where((element) => element.parentId == null).toList();
  }

  List<CommentModel> getSubCommentsOf(final String parentCommentId) {
    return _parentIdToSubComments[parentCommentId];
  }

  Future<void> fetchCommentsForDeal(String dealId) async {
    final responseBody = await _apiProvider.get('/deals/$dealId/comments') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Comments Found!');
    }
    final List<CommentModel> loadedComments = CommentModel.fromJsonList(responseBody);
    _comments.clear();
    _comments.addAll(loadedComments);
    // notifyListeners();
  }

  Future<void> fetchSubCommentsForComment(final String commentId) async {
    final responseBody = await _apiProvider.get('/comments/$commentId/replies') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Comments Found!');
    }
    final List<CommentModel> loadedComments = CommentModel.fromJsonList(responseBody);
    _parentIdToSubComments.update(commentId, (subComments) => subComments = loadedComments,
        ifAbsent: () => loadedComments);
    _comments.addAll(loadedComments);
    // notifyListeners();
  }

  Future<void> fetchComment(String commentId) async {
    final responseBody = await _apiProvider.get('/comments/$commentId');
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Comments Found!');
    }
    final CommentModel comment = CommentModel.fromJson(responseBody);
    _comments.clear();
    _addComment(comment);
  }

  Future<void> fetchCommentWithSubComments(final String commentId) async {
    await fetchComment(commentId);
    await fetchSubCommentsForComment(commentId);
  }

  Future<void> deleteComment(CommentModel comment) async {
    await _apiProvider.delete('/comments/${comment.id}', token: _token);
    if (!comment.isParent()) {
      final CommentModel parent = _comments.firstWhere((element) => element.id == comment.parentId, orElse: () => null);
      if (parent != null) {
        // parent.subComments.removeWhere((c) => c.id == comment.id);
        _parentIdToSubComments.remove(parent.id);
      }
    }
    _comments.removeWhere((c) => c.id == comment.id);
    notifyListeners();
  }

  Future<void> addCommentToDeal(String dealId, String content) async {
    final addCommentToDealDto = {'content': content};
    final responseBody = await _apiProvider.post('/deals/$dealId/comments', addCommentToDealDto, token: _token);
    final CommentModel addedComment = CommentModel.fromJson(responseBody);
    _addComment(addedComment);
    notifyListeners();
  }

  Future<void> addReplyToComment(String dealId, String commentId, String replyContent) async {
    final addCommentToDealDto = {'replyContent': replyContent};
    final responseBody = await _apiProvider.post('/comments/$commentId/replies', addCommentToDealDto, token: _token);
    final CommentModel addedComment = CommentModel.fromJson(responseBody);
    await fetchSubCommentsForComment(commentId);
    // _addComment(addedComment);
    notifyListeners();
  }

  Future<void> voteForComment(String dealId, String commentId, bool isPositive) async {
    final responseBody =
        await _apiProvider.post('/comments/$commentId/votes', {'isPositive': isPositive}, token: _token);
    final CommentModel updatedComment = CommentModel.fromJson(responseBody);
    _comments[_comments.indexWhere((element) => element.id == updatedComment.id)] = updatedComment;
    notifyListeners();
  }

  CommentModel findById(String commentId) {
    return comments.firstWhere((comment) => comment.id == commentId);
  }

  void update(String token, List<CommentModel> comments) {
    _token = token;
    _comments = comments;
  }

  void _addComment(final CommentModel comment) {
    _comments.add(comment);
    if (!comment.isParent()) {
      _parentIdToSubComments.update(comment.parentId, (subComments) => subComments..add(comment),
          ifAbsent: () => [comment]);
    }
  }
}
