import 'dart:typed_data';

import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

import 'forum_users_info_model.dart';

class TopicModel {
  final String id;
  final DateTime addedAt;
  final ForumUsersInfo adderInfo;
  final String title;
  final String content;
  final bool pinned;
  final List<String> categories;
  final int numberOfPosts;

  TopicModel({
    @required this.id,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.title,
    @required this.content,
    @required this.pinned,
    @required this.categories,
    @required this.numberOfPosts,
  });

  static List<TopicModel> fromJsonList(List<dynamic> topicsSnapshot) {
    final List<TopicModel> topics = [];
    for (final topicSnapshot in topicsSnapshot) {
      topics.add(fromJson(topicSnapshot));
    }
    return topics;
  }

  static TopicModel fromJson(dynamic topicSnapshot) {
    if (topicSnapshot == null) {
      return null;
    }
    return TopicModel(
      id: topicSnapshot['id'],
      addedAt: DateUtil.parseFromStringToUtc(topicSnapshot['addedAt']),
      adderInfo: ForumUsersInfo.fromJson(topicSnapshot['adderInfo']),
      title: topicSnapshot['title'],
      content: topicSnapshot['content'],
      pinned: topicSnapshot['pinned'],
      categories: [
        ...(topicSnapshot['categories'] as List).map((e) => e['name']).toList()
      ],
      numberOfPosts: topicSnapshot['numberOfPosts'],
    );
  }

  String get adderName {
    return adderInfo != null ? adderInfo.username : 'Użytkownik usunięty';
  }

  Uint8List get userAvatar {
    if (adderInfo != null) {
      return adderInfo.avatar;
    } else {
      return null;
    }
  }

  String get userImagePath {
    if (adderInfo != null) {
      return adderInfo.imagePath;
    } else {
      return null;
    }
  }


  @override
  String toString() {
    return 'TopicModel{id: $id, addedAt: $addedAt, adderInfo: $adderInfo, title: $title, content: $content, isPinned: $pinned, categories: $categories, numberOfPosts: $numberOfPosts}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
