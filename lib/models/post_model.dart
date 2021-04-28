import 'package:flutter/material.dart';

import 'adder_info_model.dart';

class PostModel {
  final String id;
  final DateTime addedAt;
  final AdderInfoModel adderInfo;
  final String content;
  final String quote;
  final String replyForId;
  final String replyForUserId;
  final String replyForUsername;

  const PostModel({
    @required this.id,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.content,
    @required this.quote,
    @required this.replyForId,
    @required this.replyForUserId,
    @required this.replyForUsername,
  });

  static PostModel fromJson(dynamic postSnapshot) {
    if (postSnapshot == null) {
      return null;
    }
    return PostModel(
      id: postSnapshot['id'],
      addedAt: DateTime.parse(postSnapshot['addedAt']),
      adderInfo: AdderInfoModel.fromJson(postSnapshot['adderInfo']),
      content: postSnapshot['content'],
      quote: postSnapshot['quote'],
      replyForId: postSnapshot['replyForId'],
      replyForUserId: postSnapshot['replyForUserId'],
      replyForUsername: postSnapshot['replyForUsername'],
    );
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
