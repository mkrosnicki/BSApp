import 'package:BSApp/models/adder_info_model.dart';

class CommentModel {
  final String id;
  final String content;
  final String quote;
  final List<CommentModel> subComments;
  final int points;
  final String parentId;
  final String replyForId;
  final String replyForUserId;
  final String replyForUsername;
  final DateTime addedAt;
  final AdderInfoModel adderInfo;
  final int numberOfPositiveVotes;
  final int numberOfNegativeVotes;
  final List<String> positiveVoters;
  final List<String> negativeVoters;

  CommentModel(
      {this.id,
      this.content,
      this.quote,
      this.subComments,
      this.points,
      this.parentId,
      this.replyForId,
      this.replyForUserId,
      this.replyForUsername,
      this.addedAt,
      this.adderInfo,
      this.numberOfPositiveVotes,
      this.numberOfNegativeVotes,
      this.positiveVoters,
      this.negativeVoters});

  static List<CommentModel> fromJsonList(List<dynamic> commentsSnapshot) {
    final List<CommentModel> comments = [];
    for (final commentSnapshot in commentsSnapshot) {
      comments.add(fromJson(commentSnapshot));
    }
    return comments;
  }

  static CommentModel fromJson(dynamic commentSnapshot) {
    if (commentSnapshot == null) {
      return null;
    }
    return CommentModel(
      id: commentSnapshot['id'],
      content: commentSnapshot['content'],
      quote: commentSnapshot['quote'],
      parentId: commentSnapshot['parentId'],
      replyForId: commentSnapshot['replyForId'],
      replyForUserId: commentSnapshot['replyForUserId'],
      replyForUsername: commentSnapshot['replyForUsername'],
      points: commentSnapshot['points'],
      subComments: (commentSnapshot['subComments'] as List)
          .map((e) => CommentModel.fromJson(e))
          .toList(),
      addedAt: DateTime.parse(commentSnapshot['addedAt']),
      adderInfo: AdderInfoModel.fromJson(commentSnapshot['adderInfo']),
      numberOfPositiveVotes: commentSnapshot['numberOfPositiveVotes'],
      numberOfNegativeVotes: commentSnapshot['numberOfNegativeVotes'],
      positiveVoters: [...commentSnapshot['positiveVoters'] as List],
      negativeVoters: [...commentSnapshot['negativeVoters'] as List],
    );
  }

  @override
  String toString() {
    return 'CommentModel{id: $id, content: $content, quote: $quote, subComments: $subComments, points: $points, parentId: $parentId, replyForId: $replyForId, replyForUserId: $replyForUserId, replyForUsername: $replyForUsername, addedAt: $addedAt, adderInfo: $adderInfo}';
  }
}
