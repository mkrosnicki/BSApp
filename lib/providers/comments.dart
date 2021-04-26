import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Comments with ChangeNotifier {
  ApiProvider _apiProvider = new ApiProvider();

  List<CommentModel> fetchedDealComments = [];
  List<CommentModel> fetchedAddedComments = [];
  String token;

  Comments.empty();

  Comments({this.fetchedDealComments, this.fetchedAddedComments, this.token});

  List<CommentModel> get allDealComments {
    return [...fetchedDealComments];
  }

  List<CommentModel> get mainDealComments {
    return fetchedDealComments.where((element) => element.parentId == null).toList();
  }

  List<CommentModel> get allAddedComments {
    return [...fetchedAddedComments];
  }

  List<CommentModel> get mainAddedComments {
    return fetchedAddedComments.where((element) => element.parentId == null).toList();
  }

  Future<void> fetchCommentsForDeal(String dealId) async {
    final List<CommentModel> loadedComments = [];
    final responseBody =
        await _apiProvider.get('/deals/$dealId/comments') as List;
    if (responseBody == null) {
      print('No Comments Found!');
    }
    responseBody.forEach((element) {
      var comment = CommentModel.fromJson(element);
      loadedComments.add(comment);
      loadedComments.addAll(comment.subComments);
    });
    fetchedDealComments = loadedComments;
    notifyListeners();
  }

  Future<void> fetchAddedComments() async {
    final List<CommentModel> loadedComments = [];
    final responseBody =
    await _apiProvider.get('/users/me/comments', token: token) as List;
    if (responseBody == null) {
      print('No Comments Found!');
    }
    responseBody.forEach((element) {
      var comment = CommentModel.fromJson(element);
      loadedComments.add(comment);
      loadedComments.addAll(comment.subComments);
    });
    fetchedAddedComments = loadedComments;
    notifyListeners();
  }

  Future<void> addCommentToDeal(String dealId, String content) async {
    final addCommentToDealDto = {'content': content};
    await _apiProvider.post('/deals/$dealId/comments', addCommentToDealDto, token: token);
    return fetchCommentsForDeal(dealId);
  }

  Future<void> addReplyToComment(String dealId, String commentId, String replyContent) async {
    final addCommentToDealDto = {'replyContent': replyContent};
    await _apiProvider.post('/comments/$commentId/replies', addCommentToDealDto, token: token);
    return fetchCommentsForDeal(dealId);
  }

  Future<void> voteForComment(String dealId, String commentId, bool isPositive) async {
    await _apiProvider.post('/comments/$commentId/votes', {'isPositive': isPositive}, token: token);
    return fetchCommentsForDeal(dealId);
  }

  CommentModel findById(String commentId) {
    return allDealComments.firstWhere((comment) => comment.id == commentId);
  }

  bool wasVotedPositivelyBy(String commentId, String userId) {
    return findById(commentId).positiveVoters.any((element) => element == userId);
  }

  bool wasVotedNegativelyBy(String commentId, String userId) {
    return findById(commentId).negativeVoters.any((element) => element == userId);
  }
}
