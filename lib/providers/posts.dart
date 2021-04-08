import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Posts with ChangeNotifier {
  ApiProvider _apiProvider = new ApiProvider();

  List<PostModel> fetchedTopicPosts = [];
  List<PostModel> fetchedAddedPosts = [];
  String token;

  Posts.empty();

  Posts({this.fetchedTopicPosts, this.fetchedAddedPosts, this.token});

  List<PostModel> get allTopicPosts {
    return [...fetchedTopicPosts];
  }

  List<PostModel> get addedPosts {
    return [...fetchedAddedPosts];
  }

  Future<void> fetchPostsForTopic(String topicId) async {
    final List<PostModel> loadedPosts = [];
    final responseBody =
        await _apiProvider.get('/topics/$topicId/posts') as List;
    if (responseBody == null) {
      print('No Posts Found!');
    }
    responseBody.forEach((element) {
      var post = PostModel.of(element);
      loadedPosts.add(post);
    });
    fetchedTopicPosts = loadedPosts;
    notifyListeners();
  }

  Future<void> fetchAddedPosts() async {
    final List<PostModel> loadedPosts = [];
    final responseBody =
        await _apiProvider.get('/users/me/posts', token: token) as List;
    if (responseBody == null) {
      print('No Posts Found!');
    }
    responseBody.forEach((element) {
      var post = PostModel.of(element);
      loadedPosts.add(post);
    });
    fetchedAddedPosts = loadedPosts;
    notifyListeners();
  }

  Future<void> addPostToTopic(String topicId, String content) async {
    final addPostToTopicDto = {
      'topicId': topicId,
      'content': content,
    };
    await _apiProvider.post('/posts', addPostToTopicDto, token: token);
    return fetchPostsForTopic(topicId);
  }

  Future<void> addReplyToPost(
      String topicId, String postId, String replyContent, String quote) async {
    final addReplyToPostDto = {
      'topicId': topicId,
      'replyForPostId': postId,
      'content': replyContent,
      'quote': quote
    };
    await _apiProvider.post('/posts', addReplyToPostDto, token: token);
    return fetchPostsForTopic(topicId);
  }

  PostModel findById(String postId) {
    return allTopicPosts.firstWhere((post) => post.id == postId);
  }

  void update(String token) async {
    this.token = token;
    if (token == null) {
      fetchedTopicPosts = [];
      fetchedAddedPosts = [];
    } else {
      // todo
      // await fetchAddedTopics();
      // await fetchObservedTopics();
    }
  }
}
