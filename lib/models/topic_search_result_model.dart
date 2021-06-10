import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicSearchResultModel {
  final TopicModel topic;
  final List<String> matchingPosts;

  TopicSearchResultModel({
    @required this.topic,
    @required this.matchingPosts,
  });

  static List<TopicSearchResultModel> fromJsonList(List<dynamic> topicsSnapshot) {
    final List<TopicSearchResultModel> topics = [];
    for (final topicSnapshot in topicsSnapshot) {
      topics.add(fromJson(topicSnapshot));
    }
    return topics;
  }

  static TopicSearchResultModel fromJson(dynamic topicSnapshot) {
    if (topicSnapshot == null) {
      return null;
    }
    return TopicSearchResultModel(
      topic: TopicModel.fromJson(topicSnapshot['topic']),
      matchingPosts: [...topicSnapshot['matchingPosts'] as List],
    );
  }
}
