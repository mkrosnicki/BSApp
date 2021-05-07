import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Topics with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<TopicModel> allTopics = [];
  List<TopicModel> fetchedObservedTopics = [];
  List<TopicModel> fetchedAddedTopics = [];
  List<TopicModel> fetchedCategoryTopics = [];
  String token;

  Topics({this.allTopics, this.fetchedObservedTopics, this.token});

  Topics.empty();

  List<TopicModel> get topics {
    return [...allTopics];
  }

  List<TopicModel> get observedTopics {
    return [...fetchedObservedTopics];
  }

  List<TopicModel> get addedTopics {
    return [...fetchedAddedTopics];
  }

  List<TopicModel> get categoryTopics {
    return [...fetchedCategoryTopics];
  }

  List<TopicModel> get categoryTopicsPinned {
    return fetchedCategoryTopics.where((element) => element.pinned).toList();
  }

  List<TopicModel> get categoryTopicsNotPinned {
    return fetchedCategoryTopics.where((element) => !element.pinned).toList();
  }

  Future<void> fetchTopics({Map<String, dynamic> requestParams}) async {
    final responseBody =
        await _apiProvider.get('/topics', requestParams: requestParams) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    allTopics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchCategoryTopics(String categoryId) async {
    final responseBody =
    await _apiProvider.get('/topics', requestParams: {'categoryId': categoryId}) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    fetchedCategoryTopics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchObservedTopics() async {
    final responseBody =
        await _apiProvider.get('/users/me/topics/observed', token: token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    fetchedObservedTopics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchAddedTopics() async {
    final responseBody =
        await _apiProvider.get('/users/me/topics/added', token: token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    fetchedAddedTopics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }


  Future<TopicModel> addNewTopic(String title, String content, String categoryId) async {
    final addNewTopicDto = {
      'title': title,
      'content': content,
      'categoriesIds': [categoryId]
    };
    final topicSnapshot = await _apiProvider.post('/topics', addNewTopicDto, token: token);
    await fetchCategoryTopics(categoryId);
    return TopicModel.fromJson(topicSnapshot);
  }

  Future<void> addToObservedTopics(String topicId) async {
    final addTopicToFavouritesDto = {'topicId': topicId};
    await _apiProvider.post('/users/me/topics/observed', addTopicToFavouritesDto, token: token);
    return fetchObservedTopics();
  }

  Future<void> removeFromObservedTopics(String topicId) async {
    await _apiProvider.delete('/users/me/topics/observed/$topicId', token: token);
    return fetchObservedTopics();
  }

  Future<void> voteForTopic(String topicId, bool isPositive) async {
    await _apiProvider.post('/topics/$topicId/votes',
        {'isPositive': isPositive},
        token: token);
    return fetchTopics();
  }

  TopicModel findById(String topicId) {
    return categoryTopics.firstWhere((topic) => topic.id == topicId);
  }

  bool wasVotedPositivelyBy(String topicId, String userId) {
    return findById(topicId).positiveVoters.any((element) => element == userId);
  }

  bool wasVotedNegativelyBy(String topicId, String userId) {
    return findById(topicId).negativeVoters.any((element) => element == userId);
  }

  bool isObservedTopic(TopicModel topic) {
    return fetchedObservedTopics.contains(topic);
  }

  bool isObservedTopicById(String topicId) {
    return fetchedObservedTopics.any((topic) => topic.id == topicId);
  }

  Future<void> update(String token) async {
    this.token = token;
    if (token == null) {
      fetchedObservedTopics = [];
      fetchedAddedTopics = [];
    } else {
      await fetchObservedTopics();
    }
  }
}
