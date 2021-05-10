import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Searches with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<SearchModel> _searches = [];
  String _token;

  Searches.empty();

  List<SearchModel> get searches {
    return [..._searches];
  }

  Future<void> fetchObservedSearches() async {
    final responseBody = await _apiProvider.get('/users/me/subscriptions',
        token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Subscriptions Found!');
    }
    _searches = SearchModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> update(String token, List<SearchModel> searches) async {
    _token = token;
    _searches = searches;
  }
}
