import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicDetailsModel {
  final TopicModel topic;
  final List<PostModel> posts;

  TopicDetailsModel({
    @required this.topic,
    @required this.posts,
  });

  static TopicDetailsModel of(dynamic topicDetailsSnapshot) {
    return TopicDetailsModel(
      topic: TopicModel.of(topicDetailsSnapshot['topic']),
      posts: (topicDetailsSnapshot['posts'] as List).map((e) => PostModel.of(e)).toList(),
    );
  }


  @override
  String toString() {
    return 'TopicDetailsModel{topic: $topic}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicDetailsModel &&
          runtimeType == other.runtimeType &&
          topic == other.topic;

  @override
  int get hashCode => topic.hashCode;
}
