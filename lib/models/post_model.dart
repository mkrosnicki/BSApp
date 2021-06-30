import 'dart:typed_data';

import 'package:BSApp/models/post_adder_info_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class PostModel {
  final String id;
  final DateTime addedAt;
  final PostAdderInfoModel adderInfo;
  final String content;
  final String quote;
  final String repliedId;
  final String repliedUserId;
  final String repliedUsername;
  final List<String> likers;


  const PostModel({
    @required this.id,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.content,
    @required this.quote,
    @required this.repliedId,
    @required this.repliedUserId,
    @required this.repliedUsername,
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
      addedAt: DateUtil.parseFromStringToUtc(postSnapshot['addedAt']),
      adderInfo: PostAdderInfoModel.fromJson(postSnapshot['adderInfo']),
      content: postSnapshot['content'],
      quote: postSnapshot['quote'],
      repliedId: postSnapshot['repliedId'],
      repliedUserId: postSnapshot['repliedUserId'],
      repliedUsername: postSnapshot['repliedUsername'],
      likers: [...postSnapshot['likers'] as List],
    );
  }

  bool wasLikedBy(String userId) {
    return likers.any((element) => element == userId);
  }

  String get adderName {
    return adderInfo != null ? adderInfo.username : 'Użytkownik usunięty';
  }

  Uint8List get userAvatar {
    return adderInfo != null ? adderInfo.avatar : null;
  }

  String get userImagePath {
    return adderInfo != null ? adderInfo.imagePath : null;
  }

  @override
  String toString() {
    return 'PostModel{id: $id, addedAt: $addedAt, adderInfo: $adderInfo, content: $content, quote: $quote, replyForId: $repliedId, replyForUserId: $repliedUserId, replyForUsername: $repliedUsername}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
