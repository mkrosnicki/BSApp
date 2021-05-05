import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Topics with ChangeNotifier {
  ApiProvider _apiProvider = new ApiProvider();

  List<TopicModel> allTopics = [];
  List<TopicModel> fetchedObservedTopics = [];
  List<TopicModel> fetchedAddedTopics = [];
  List<TopicModel> fetchedCategoryTopics = [];
  String token;

  Topics.empty();

  Topics({this.allTopics, this.fetchedObservedTopics, this.token});

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
    final List<TopicModel> loadedTopics = [];
    final responseBody =
        await _apiProvider.get('/topics', requestParams: requestParams) as List;
    if (responseBody == null) {
      print('No Topics Found!');
    }
    responseBody.forEach((element) {
      loadedTopics.add(TopicModel.fromJson(element));
    });
    allTopics = loadedTopics;
    notifyListeners();
  }

  Future<void> fetchCategoryTopics(String categoryId) async {
    final List<TopicModel> loadedTopics = [];
    final responseBody =
    await _apiProvider.get('/topics', requestParams: {'categoryId': categoryId}) as List;
    if (responseBody == null) {
      print('No Topics Found!');
    }
    responseBody.forEach((element) {
      loadedTopics.add(TopicModel.fromJson(element));
    });
    fetchedCategoryTopics = loadedTopics;
    notifyListeners();
  }

  Future<void> fetchObservedTopics() async {
    final List<TopicModel> fetchedTopics = [];
    final responseBody =
        await _apiProvider.get('/users/me/topics/observed', token: token) as List;
    if (responseBody == null) {
      print('No Topics Found!');
    }
    responseBody.forEach((element) {
      fetchedTopics.add(TopicModel.fromJson(element));
    });
    fetchedObservedTopics = fetchedTopics;
    notifyListeners();
  }

  Future<void> fetchAddedTopics() async {
    final List<TopicModel> fetchedTopics = [];
    final responseBody =
        await _apiProvider.get('/users/me/topics/added', token: token) as List;
    if (responseBody == null) {
      print('No Topics Found!');
    }
    responseBody.forEach((element) {
      fetchedTopics.add(TopicModel.fromJson(element));
    });
    fetchedAddedTopics = fetchedTopics;
    notifyListeners();
  }


  Future<TopicModel> addNewTopic(String title, String content, String categoryId) async {
    final addNewTopicDto = {
      'title': title,
      'content': content,
      'categoriesIds': [categoryId]
    };
    var topicSnapshot = await _apiProvider.post('/topics', addNewTopicDto, token: token);
    await fetchCategoryTopics(categoryId);
    return TopicModel.fromJson(topicSnapshot);
  }

  Future<void> addToObservedTopics(String topicId) async {
    final addTopicToFavouritesDto = {'topicId': topicId};
    await _apiProvider.post('/users/me/topics/observed', addTopicToFavouritesDto, token: token);
    return fetchObservedTopics();
  }

  Future<void> deleteFromObservedTopics(String topicId) async {
    await _apiProvider.delete('TODO$topicId', token: token);
    return fetchObservedTopics();
  }

  Future<void> voteForTopic(String topicId, bool isPositive) async {
    await _apiProvider.post(
        '/topics/$topicId/votes', {'isPositive': isPositive},
        token: token);
    return fetchTopics();
  }

  // Future<TopicModel> fetchById(String topicId) async {
  //   final responseBody = await _apiProvider.get('/topics/$topicId');
  //   if (responseBody == null) {
  //     print('No Topic Found!');
  //   }
  //   return TopicModel.fromJson(responseBody);
  // }

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

  void update(String token) async {
    this.token = token;
    if (token == null) {
      fetchedObservedTopics = [];
      fetchedAddedTopics = [];
    } else {
      // todo
      // await fetchAddedTopics();
      // await fetchObservedTopics();
    }
  }
}
