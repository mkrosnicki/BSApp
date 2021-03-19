import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Searches with ChangeNotifier {
  ApiProvider _apiProvider = new ApiProvider();

  List<CommentModel> fetchedSavedSearches = [];
  String token;

  Searches({this.fetchedSavedSearches, this.token});

  List<CommentModel> get savedSearches {
    return [...fetchedSavedSearches];
  }

  Future<void> fetchSavedSearches() async {
    final List<CommentModel> loadedSearches = [];
    final responseBody =
    await _apiProvider.get('/users/me/subscriptions', token: token) as List;
    if (responseBody == null) {
      print('No Searches Found!');
    }
    responseBody.forEach((element) {
      loadedSearches.add(CommentModel.of(element));
    });
    fetchedSavedSearches = loadedSearches;
    notifyListeners();
  }

  Future<void> saveSearch(Map<String, dynamic> saveSearchDto) async {
    await _apiProvider.post('/users/me/subscriptions', saveSearchDto, token: token);
    notifyListeners();
  }
}
