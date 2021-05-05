import 'dart:convert';

import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

import 'deal_model.dart';

class UserModel {
  final String id;
  final String username;
  final DateTime registeredAt;
  final DateTime lastLoginAt;
  final List<PostModel> addedPosts;
  final List<TopicModel> addedTopics;
  final List<DealModel> addedDeals;
  final List<CommentModel> addedComments;
  final Image avatar;

  UserModel(
      {this.id,
      this.username,
      this.registeredAt,
      this.lastLoginAt,
      this.addedPosts,
      this.addedComments,
      this.addedDeals,
      this.addedTopics,
      this.avatar});

  static UserModel fromJson(dynamic userSnapshot) {
    return UserModel(
        id: userSnapshot['id'],
        username: userSnapshot['username'],
        registeredAt: DateTime.parse(userSnapshot['registeredAt']),
        // lastLoginAt: DateTime.parse(userSnapshot['lastLoginAt']),
        lastLoginAt: null,
        // todo
        addedPosts: (userSnapshot['addedPosts'] as List)
            .map((e) => PostModel.fromJson(e))
            .toList(),
        addedTopics: (userSnapshot['addedTopics'] as List)
            .map((e) => TopicModel.fromJson(e))
            .toList(),
        addedDeals: (userSnapshot['addedDeals'] as List)
            .map((e) => DealModel.fromJson(e))
            .toList(),
        addedComments: (userSnapshot['addedComments'] as List)
            .map((e) => CommentModel.fromJson(e))
            .toList(),
        avatar: _getImage(userSnapshot));
  }

  static _getImage(userSnapshot) {
    var encodedAvatar = userSnapshot['avatar'];
    if (encodedAvatar == null) {
      return null;
    }
    var base64Avatar = base64Decode(encodedAvatar);
    return Image.memory(base64Avatar);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, registeredAt: $registeredAt, lastLoginAt: $lastLoginAt, addedPosts: $addedPosts, addedTopics: $addedTopics, addedDeals: $addedDeals, addedComments: $addedComments}';
  }
}
