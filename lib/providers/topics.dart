import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Topics with ChangeNotifier {
  ApiProvider _apiProvider = new ApiProvider();

  List<TopicModel> allTopics = [];
  List<TopicModel> fetchedObservedTopics = [];
  List<TopicModel> fetchedAddedTopics = [];
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

  Future<void> fetchTopics({Map<String, dynamic> requestParams}) async {
    final List<TopicModel> loadedTopics = [];
    final responseBody =
        await _apiProvider.get('/topics', requestParams: requestParams) as List;
    if (responseBody == null) {
      print('No Topics Found!');
    }
    // print(responseBody);
    responseBody.forEach((element) {
      loadedTopics.add(TopicModel.of(element));
    });
    allTopics = loadedTopics;
    notifyListeners();
  }

  Future<void> fetchObservedTopics() async {
    final List<TopicModel> fetchedTopics = [];
    final responseBody =
        await _apiProvider.get('/users/me/observed', token: token) as List;
    if (responseBody == null) {
      print('No Topics Found!');
    }
    responseBody.forEach((element) {
      fetchedTopics.add(TopicModel.of(element));
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
      fetchedTopics.add(TopicModel.of(element));
    });
    fetchedAddedTopics = fetchedTopics;
    notifyListeners();
  }

  Future<void> addToObservedTopics(String topicId) async {
    final addTopicToFavouritesDto = {'topicId': topicId};
    await _apiProvider.post('TODO', addTopicToFavouritesDto, token: token);
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

  TopicModel findById(String topicId) {
    return allTopics.firstWhere((topic) => topic.id == topicId);
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