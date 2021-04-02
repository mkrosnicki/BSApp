import 'package:BSApp/models/adder_info_model.dart';
import 'package:flutter/material.dart';

class TopicModel {
  final String id;
  final DateTime addedAt;
  final AdderInfoModel adderInfo;
  final String title;
  final String content;
  final List<String> categories;
  final int numberOfPosts;
  final int numberOfPositiveVotes;
  final int numberOfNegativeVotes;
  final List<String> positiveVoters;
  final List<String> negativeVoters;

  TopicModel({
    @required this.id,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.title,
    @required this.content,
    @required this.categories,
    @required this.numberOfPosts,
    @required this.numberOfPositiveVotes,
    @required this.numberOfNegativeVotes,
    @required this.positiveVoters,
    @required this.negativeVoters,
  });

  static TopicModel of(dynamic topicSnapshot) {
    print(topicSnapshot);
    return TopicModel(
      id: topicSnapshot['id'],
      addedAt: DateTime.parse(topicSnapshot['addedAt']),
      adderInfo: AdderInfoModel.of(topicSnapshot['adderInfo']),
      title: topicSnapshot['title'],
      content: topicSnapshot['content'],
      categories: [
        ...(topicSnapshot['categories'] as List).map((e) => e['name']).toList()
      ],
      numberOfPosts: topicSnapshot['numberOfPosts'],
      numberOfPositiveVotes: topicSnapshot['numberOfPositiveVotes'],
      numberOfNegativeVotes: topicSnapshot['numberOfNegativeVotes'],
      positiveVoters: [...topicSnapshot['positiveVoters'] as List],
      negativeVoters: [...topicSnapshot['negativeVoters'] as List],
    );
  }

  @override
  String toString() {
    return 'TopicModel{id: $id, addedAt: $addedAt, adderInfoModel: $adderInfo, title: $title, content: $content, categories: $categories, numberOfPosts: $numberOfPosts, numberOfPositiveVotes: $numberOfPositiveVotes, numberOfNegativeVotes: $numberOfNegativeVotes, positiveVoters: $positiveVoters, negativeVoters: $negativeVoters}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
