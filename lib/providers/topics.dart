import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Topics with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<TopicModel> _topics = [];
  String _token;

  Topics.empty();

  List<TopicModel> get topics {
    return [..._topics];
  }

  List<TopicModel> get pinnedTopics {
    return topics.where((element) => element.pinned).toList();
  }

  List<TopicModel> get notPinnedTopics {
    return topics.where((element) => !element.pinned).toList();
  }

  Future<void> fetchTopics({Map<String, dynamic> requestParams}) async {
    final responseBody =
        await _apiProvider.get('/topics', requestParams: requestParams) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _topics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchCategoryTopics(String categoryId) async {
    final responseBody = await _apiProvider
        .get('/topics', requestParams: {'categoryId': categoryId}) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _topics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchObservedTopics() async {
    final responseBody = await _apiProvider.get('/users/me/topics/observed',
        token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _topics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchAddedTopics() async {
    final responseBody =
        await _apiProvider.get('/users/me/topics/added', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _topics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchTopicsAddedBy(String userId) async {
    final responseBody =
        await _apiProvider.get('/users/$userId/topics/added') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Topics Found!');
    }
    _topics = TopicModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<TopicModel> addNewTopic(
      String title, String content, String categoryId) async {
    final addNewTopicDto = {
      'title': title,
      'content': content,
      'categoriesIds': [categoryId]
    };
    final topicSnapshot =
        await _apiProvider.post('/topics', addNewTopicDto, token: _token);
    final TopicModel newTopic = TopicModel.fromJson(topicSnapshot);
    _topics.add(newTopic);
    return newTopic;
  }

  Future<void> voteForTopic(String topicId, bool isPositive) async {
    final responseBody = await _apiProvider.post(
        '/topics/$topicId/votes', {'isPositive': isPositive},
        token: _token);
    final TopicModel votedTopic = TopicModel.fromJson(responseBody);
    _topics[_topics.indexWhere((element) => element.id == votedTopic.id)] =
        votedTopic;
    notifyListeners();
  }

  Future<void> update(String token, List<TopicModel> topics) async {
    _token = token;
    _topics = topics;
  }
}
