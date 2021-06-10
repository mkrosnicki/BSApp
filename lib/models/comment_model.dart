import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/util/date_util.dart';

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
      id: commentSnapshot['id'] as String,
      content: commentSnapshot['content'] as String,
      quote: commentSnapshot['quote'] as String,
      parentId: commentSnapshot['parentId'] as String,
      replyForId: commentSnapshot['replyForId'] as String,
      replyForUserId: commentSnapshot['replyForUserId'] as String,
      replyForUsername: commentSnapshot['replyForUsername'] as String,
      points: commentSnapshot['points'] as int,
      subComments: (commentSnapshot['subComments'] as List)
          .map((e) => CommentModel.fromJson(e))
          .toList(),
      addedAt: DateUtil.parseFromStringToUtc(commentSnapshot['addedAt'] as String),
      adderInfo: AdderInfoModel.fromJson(commentSnapshot['adderInfo']),
      numberOfPositiveVotes: commentSnapshot['numberOfPositiveVotes'] as int,
      numberOfNegativeVotes: commentSnapshot['numberOfNegativeVotes'] as int,
      positiveVoters: [...commentSnapshot['positiveVoters'] as List],
      negativeVoters: [...commentSnapshot['negativeVoters'] as List],
    );
  }

  bool hasPositiveVoteFrom(String userId) {
    return positiveVoters.any((element) => element == userId);
  }

  bool hasNegativeVoteFrom(String userId) {
    return negativeVoters.any((element) => element == userId);
  }

  bool isParent() {
    return parentId == null;
  }

  @override
  String toString() {
    return 'CommentModel{id: $id, content: $content, quote: $quote, subComments: $subComments, points: $points, parentId: $parentId, replyForId: $replyForId, replyForUserId: $replyForUserId, replyForUsername: $replyForUsername, addedAt: $addedAt, adderInfo: $adderInfo}';
  }
}
