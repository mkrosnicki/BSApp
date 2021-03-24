import 'package:BSApp/models/adder_info_model.dart';

class CommentModel {
  final String id;
  final String content;
  final List<CommentModel> subComments;
  final int points;
  final String parentId;
  final DateTime addedAt;
  final AdderInfoModel adderInfo;

  CommentModel(
      {this.id,
      this.content,
      this.subComments,
      this.points,
      this.parentId,
      this.addedAt,
      this.adderInfo});

  static CommentModel of(dynamic commentSnapshot) {
    return CommentModel(
      id: commentSnapshot['id'],
      content: commentSnapshot['content'],
      parentId: commentSnapshot['parentId'],
      points: commentSnapshot['points'],
      subComments: (commentSnapshot['subComments'] as List)
          .map((e) => CommentModel.of(e))
          .toList(),
      addedAt: DateTime.parse(commentSnapshot['addedAt']),
      adderInfo: AdderInfoModel.of(commentSnapshot['adderInfo']),
    );
  }
}
