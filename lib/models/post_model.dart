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

  PostModel({
    @required this.id,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.content,
    @required this.quote,
    @required this.replyForId,
    @required this.replyForUserId,
    @required this.replyForUsername,
  });

  static PostModel of(dynamic topicSnapshot) {
    return PostModel(
      id: topicSnapshot['id'],
      addedAt: DateTime.parse(topicSnapshot['addedAt']),
      adderInfo: AdderInfoModel.of(topicSnapshot['adderInfo']),
      content: topicSnapshot['content'],
      quote: topicSnapshot['quote'],
      replyForId: topicSnapshot['replyForId'],
      replyForUserId: topicSnapshot['replyForUserId'],
      replyForUsername: topicSnapshot['replyForUsername'],
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
