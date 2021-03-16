import 'package:BSApp/models/comment-model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Comments with ChangeNotifier {
  ApiProvider _apiProvider = new ApiProvider();

  List<CommentModel> fetchedDealComments = [];
  String token;

  Comments({this.fetchedDealComments, this.token});

  List<CommentModel> get dealComments {
    return [...fetchedDealComments];
  }

  Future<void> fetchCommentsForDeal(String dealId) async {
    final List<CommentModel> loadedComments = [];
    final responseBody =
        await _apiProvider.get('/deals/$dealId/comments') as List;
    if (responseBody == null) {
      print('No Comments Found!');
    }
    responseBody.forEach((element) {
      loadedComments.add(CommentModel.of(element));
    });
    fetchedDealComments = loadedComments;
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
}
