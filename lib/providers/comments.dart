import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Comments with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<CommentModel> _comments = [];
  String _token;

  Comments.empty();

  List<CommentModel> get comments {
    return [..._comments];
  }

  List<CommentModel> get parentComments {
    return _comments.where((element) => element.parentId == null).toList();
  }

  Future<void> fetchCommentsForDeal(String dealId) async {
    final List<CommentModel> loadedComments = [];
    final responseBody =
        await _apiProvider.get('/deals/$dealId/comments') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Comments Found!');
    }
    responseBody.forEach((element) {
      final comment = CommentModel.fromJson(element);
      loadedComments.add(comment);
      loadedComments.addAll(comment.subComments);
    });
    _comments = loadedComments;
    notifyListeners();
  }

  Future<void> addCommentToDeal(String dealId, String content) async {
    final addCommentToDealDto = {'content': content};
    await _apiProvider.post('/deals/$dealId/comments', addCommentToDealDto, token: _token);
    return fetchCommentsForDeal(dealId);
  }

  Future<void> addReplyToComment(String dealId, String commentId, String replyContent) async {
    final addCommentToDealDto = {'replyContent': replyContent};
    await _apiProvider.post('/comments/$commentId/replies', addCommentToDealDto, token: _token);
    return fetchCommentsForDeal(dealId);
  }

  Future<void> voteForComment(String dealId, String commentId, bool isPositive) async {
    final responseBody = await _apiProvider.post('/comments/$commentId/votes', {'isPositive': isPositive}, token: _token);
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
}
