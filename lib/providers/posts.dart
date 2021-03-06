import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Posts with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<PostModel> _posts = [];
  final List<PostModel> _topicPosts = [];
  String _token;

  Posts.empty();

  List<PostModel> get posts {
    return [..._posts];
  }

  List<PostModel> get topicPosts {
    return _topicPosts;
  }

  Future<void> fetchPostsForTopic(String topicId) async {
    final responseBody =
        await _apiProvider.get('/topics/$topicId/posts') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Posts Found!');
    }
    final List<PostModel> loadedPosts = PostModel.fromJsonList(responseBody);
    _posts.clear();
    _posts.addAll(loadedPosts);
    _topicPosts.clear();
    _topicPosts.addAll(loadedPosts);
    notifyListeners();
  }

  Future<void> fetchAddedPosts() async {
    final responseBody =
        await _apiProvider.get('/users/me/posts', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Posts Found!');
    }
    _posts = PostModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> deletePost(String postId) async {
    await _apiProvider.delete('/posts/$postId', token: _token);
    _posts.removeWhere((post) => post.id == postId);
    notifyListeners();
  }

  Future<void> addPostToTopic(String topicId, String content) async {
    final addPostToTopicDto = {
      'topicId': topicId,
      'content': content,
    };
    await _apiProvider.post('/posts', addPostToTopicDto, token: _token);
    return fetchPostsForTopic(topicId);
  }

  Future<void> addReplyToPost(
      String topicId, String postId, String replyContent, String quote) async {
    final addReplyToPostDto = {
      'topicId': topicId,
      'repliedPostId': postId,
      'content': replyContent,
      'quote': quote
    };
    await _apiProvider.post('/posts', addReplyToPostDto, token: _token);
    return fetchPostsForTopic(topicId);
  }

  PostModel findById(String postId) {
    return posts.firstWhere((post) => post.id == postId);
  }

  Future<void> likeThePost(PostModel post, bool isLike) async {
    final responseBody = await _apiProvider.post('/posts/${post.id}/likes', {'isLike': isLike}, token: _token);
    final PostModel updatedPost = PostModel.fromJson(responseBody);
    _posts[_posts.indexWhere((element) => element.id == updatedPost.id)] = updatedPost;
    notifyListeners();
  }

  void update(String token, List<PostModel> posts) {
    _token = token;
    _posts = posts;
  }
}
