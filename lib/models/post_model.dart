import 'package:flutter/material.dart';

import 'adder_info_model.dart';

class PostModel {
  final String id;
  final String topicId;
  final DateTime addedAt;
  final AdderInfoModel adderInfo;
  final String content;
  final String quote;
  final String replyForId;
  final String replyForUserId;
  final String replyForUsername;
  final List<String> likers;


  const PostModel({
    @required this.id,
    @required this.topicId,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.content,
    @required this.quote,
    @required this.replyForId,
    @required this.replyForUserId,
    @required this.replyForUsername,
    @required this.likers,
  });

  static List<PostModel> fromJsonList(List<dynamic> postsSnapshot) {
    final List<PostModel> posts = [];
    for (final postSnapshot in postsSnapshot) {
      posts.add(fromJson(postSnapshot));
    }
    return posts;
  }

  static PostModel fromJson(dynamic postSnapshot) {
    if (postSnapshot == null) {
      return null;
    }
    return PostModel(
      id: postSnapshot['id'],
      topicId: postSnapshot['topicId'],
      addedAt: DateTime.parse(postSnapshot['addedAt']),
      adderInfo: AdderInfoModel.fromJson(postSnapshot['adderInfo']),
      content: postSnapshot['content'],
      quote: postSnapshot['quote'],
      replyForId: postSnapshot['replyForId'],
      replyForUserId: postSnapshot['replyForUserId'],
      replyForUsername: postSnapshot['replyForUsername'],
      likers: [...postSnapshot['likers'] as List],
    );
  }

  bool wasLikedBy(String userId) {
    return likers.any((element) => element == userId);
  }

  @override
  String toString() {
    return 'PostModel{id: $id, addedAt: $addedAt, adderInfo: $adderInfo, content: $content, quote: $quote, replyForId: $replyForId, replyForUserId: $replyForUserId, replyForUsername: $replyForUsername}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
