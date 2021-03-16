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
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      loadedComments.add(CommentModel.of(element));
    });
    fetchedDealComments = loadedComments;
    notifyListeners();
  }
}
