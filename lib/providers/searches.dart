import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Searches with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<SearchModel> fetchedSavedSearches = [];
  String token;

  Searches({this.fetchedSavedSearches, this.token});

  Searches.empty();

  List<SearchModel> get savedSearches {
    return [...fetchedSavedSearches];
  }

  Future<void> fetchSavedSearches() async {
    final List<SearchModel> loadedSearches = [];
    final responseBody =
    await _apiProvider.get('/users/me/subscriptions', token: token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Subscriptions Found!');
    }
    responseBody.forEach((element) {
      loadedSearches.add(SearchModel.of(element));
    });
    fetchedSavedSearches = loadedSearches;
    notifyListeners();
  }

  Future<void> saveSearch(Map<String, dynamic> saveSearchDto) async {
    await _apiProvider.post('/users/me/subscriptions', saveSearchDto, token: token);
    return fetchSavedSearches();
  }

  bool isSaved(FilterSettings filterSettings) {
    return savedSearches.any((element) => element.isSame(filterSettings));
  }

  Future<void> deleteSearch(String searchId) async {
    await _apiProvider.delete('/users/me/subscriptions/$searchId', token: token);
    return fetchSavedSearches();
  }

  void update(String token) async {
    this.token = token;
    if (token == null) {
      fetchedSavedSearches = [];
    } else {
      await fetchSavedSearches();
    }
  }
}
