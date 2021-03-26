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
      this.adderInfo});

  static CommentModel of(dynamic commentSnapshot) {
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
          .map((e) => CommentModel.of(e))
          .toList(),
      addedAt: DateTime.parse(commentSnapshot['addedAt']),
      adderInfo: AdderInfoModel.of(commentSnapshot['adderInfo']),
    );
  }

  @override
  String toString() {
    return 'CommentModel{id: $id, content: $content, quote: $quote, subComments: $subComments, points: $points, parentId: $parentId, replyForId: $replyForId, replyForUserId: $replyForUserId, replyForUsername: $replyForUsername, addedAt: $addedAt, adderInfo: $adderInfo}';
  }
}
