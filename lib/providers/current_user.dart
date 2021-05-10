import 'dart:convert';
import 'dart:io';

import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CurrentUser with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  UserModel _me;
  String _token;
  List<DealModel> _observedDeals = [];
  List<DealModel> _addedDeals = [];
  List<TopicModel> _observedTopics = [];
  List<SearchModel> _observedSearches = [];
  List<TopicModel> _addedTopics = [];
  List<ActivityModel> _activities;

  CurrentUser.empty();

  bool get isAuthenticated {
    return _token != null;
  }

  UserModel get me {
    return _me;
  }

  String get token {
    return _token;
  }

  List<DealModel> get observedDeals {
    return [..._observedDeals];
  }

  List<DealModel> get addedDeals {
    return [..._addedDeals];
  }

  List<ActivityModel> get activities {
    return [..._activities];
  }

  List<TopicModel> get observedTopics {
    return [..._observedTopics];
  }

  List<TopicModel> get addedTopics {
    return [..._addedTopics];
  }

  Future<void> fetchMe() async {
    final responseBody = await _apiProvider.get('/users/me', token: _token);
    final UserDetailsModel details = UserDetailsModel.fromJson(responseBody);
    _me = details.user;
    _observedDeals = details.observedDeals;
    _observedTopics = details.observedTopics;
    _observedSearches = details.observedSearches;
  }

  Future<void> _fetchObservedDeals() async {
    final responseBody =
    await _apiProvider.get('/users/me/deals/observed', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _observedDeals = DealModel.fromJsonList(responseBody);
  }

  Future<void> _fetchAddedDeals() async {
    final responseBody = await _apiProvider.get('/users/me/deals/added', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _addedDeals = DealModel.fromJsonList(responseBody);
  }

  Future<void> fetchActivities() async {
    final responseBody = await _apiProvider.get('/users/me/activities', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Activities Found!');
    }
    _activities = ActivityModel.fromJsonList(responseBody);
  }

  Future<void> _fetchAddedTopics() async {
    final responseBody = await _apiProvider.get('/users/me/topics/added', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _addedTopics = TopicModel.fromJsonList(responseBody);
  }

  Future<void> _fetchObservedTopics() async {
    final responseBody = await _apiProvider.get('/users/me/topics/observed', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _observedTopics = TopicModel.fromJsonList(responseBody);
  }

  Future<void> updateMyAvatar(File newAvatar) async {
    final updateAvatarDto = {'avatar': base64Encode(newAvatar.readAsBytesSync()),};
    final responseBody = await _apiProvider.patch('/users/me/', updateAvatarDto, token: _token);
    _me = UserModel.fromJson(responseBody);
    notifyListeners();
  }

  Future<void> updateNotificationsTimestamp() async {
    final updateNotificationsTimestampDto = {'notificationsSeenAtUpdate': true};
    final responseBody = await _apiProvider.patch(
        '/users/me/', updateNotificationsTimestampDto,
        token: _token);
    _me = UserModel.fromJson(responseBody);
    // notifyListeners();
  }

  Future<void> addToObservedDeals(String dealId) async {
    final addDealToFavouritesDto = {'dealId': dealId};
    final responseBody = await _apiProvider.post('/users/me/deals/observed', addDealToFavouritesDto, token: _token);
    final DealModel addedDeal = DealModel.fromJson(responseBody);
    _observedDeals.add(addedDeal);
    notifyListeners();
  }

  Future<void> removeFromObservedDeals(String dealId) async {
    await _apiProvider.delete('/users/me/deals/observed/$dealId', token: _token);
    _observedDeals.removeWhere((element) => element.id == dealId);
    notifyListeners();
  }

  Future<void> addToObservedTopics(String topicId) async {
    final addTopicToFavouritesDto = {'topicId': topicId};
    final responseBody = await _apiProvider.post('/users/me/topics/observed', addTopicToFavouritesDto, token: _token);
    final TopicModel addedTopic = TopicModel.fromJson(responseBody);
    _observedTopics.add(addedTopic);
    notifyListeners();
  }

  Future<void> removeFromObservedTopics(String topicId) async {
    await _apiProvider.delete('/users/me/topics/observed/$topicId', token: _token);
    _observedTopics.removeWhere((element) => element.id == topicId);
    notifyListeners();
  }

  Future<void> addToObservedSearches(Map<String, dynamic> saveSearchDto) async {
    final responseBody = await _apiProvider.post('/users/me/subscriptions', saveSearchDto, token: _token);
    final SearchModel addedSearch = SearchModel.fromJson(responseBody);
    _observedSearches.add(addedSearch);
    notifyListeners();
  }

  Future<void> removeFromObservedSearches(String searchId) async {
    await _apiProvider.delete('/users/me/subscriptions/$searchId', token: _token);
    _observedSearches.removeWhere((element) => element.id == searchId);
    notifyListeners();
  }

  bool observesDeal(DealModel deal) {
    return _observedDeals.contains(deal);
  }

  bool observesTopic(TopicModel topic) {
    return _observedTopics.contains(topic);
  }

  bool observesSearch(SearchModel search) {
    return _observedSearches.contains(search);
  }

  bool observesFilterSettings(FilterSettings filterSettings) {
    return _observedSearches.any((element) => element.isSame(filterSettings));
  }

  Future<void> update(String token, String userId) async {
    _token = token;
    if (!isAuthenticated) {
      _addedDeals = [];
      _observedDeals = [];
    } else {
      await fetchMe();
    }
    notifyListeners();
  }
}
