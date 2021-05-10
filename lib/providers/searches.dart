import 'package:BSApp/models/filter_settings.dart';
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
    final responseBody =
    await _apiProvider.get('/users/me/subscriptions', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Subscriptions Found!');
    }
    _searches = SearchModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> saveSearch(Map<String, dynamic> saveSearchDto) async {
    await _apiProvider.post('/users/me/subscriptions', saveSearchDto, token: _token);
    return fetchObservedSearches();
  }

  bool isSaved(FilterSettings filterSettings) {
    return searches.any((element) => element.isSame(filterSettings));
  }

  Future<void> deleteSearch(String searchId) async {
    await _apiProvider.delete('/users/me/subscriptions/$searchId', token: _token);
    return fetchObservedSearches();
  }

  void update(String token, List<SearchModel> searches) async {
    _token = token;
    _searches = searches;
  }
}
