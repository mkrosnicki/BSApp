import 'package:flutter/material.dart';

import 'adder_info_model.dart';

class PostModel {

  final String id;
  final DateTime addedAt;
  final AdderInfoModel adderInfo;
  final String content;
  final String quote;
  final int numberOfPosts;
  final int numberOfPositiveVotes;
  final int numberOfNegativeVotes;
  final List<String> positiveVoters;
  final List<String> negativeVoters;

  PostModel({
    @required this.id,
    @required this.addedAt,
    @required this.adderInfo,
    @required this.content,
    @required this.quote,
    @required this.numberOfPosts,
    @required this.numberOfPositiveVotes,
    @required this.numberOfNegativeVotes,
    @required this.positiveVoters,
    @required this.negativeVoters,
  });

  static PostModel of(dynamic topicSnapshot) {
    return PostModel(
      id: topicSnapshot['id'],
      addedAt: DateTime.parse(topicSnapshot['addedAt']),
      adderInfo: AdderInfoModel.of(topicSnapshot['adderInfo']),
      content: topicSnapshot['content'],
      quote: topicSnapshot['quote'],
      numberOfPosts: topicSnapshot['numberOfPosts'],
      numberOfPositiveVotes: topicSnapshot['numberOfPositiveVotes'],
      numberOfNegativeVotes: topicSnapshot['numberOfNegativeVotes'],
      positiveVoters: [...topicSnapshot['positiveVoters'] as List],
      negativeVoters: [...topicSnapshot['negativeVoters'] as List],
    );
  }


  @override
  String toString() {
    return 'PostModel{id: $id, addedAt: $addedAt, adderInfo: $adderInfo, content: $content, quote: $quote, numberOfPosts: $numberOfPosts, numberOfPositiveVotes: $numberOfPositiveVotes, numberOfNegativeVotes: $numberOfNegativeVotes, positiveVoters: $positiveVoters, negativeVoters: $negativeVoters}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}