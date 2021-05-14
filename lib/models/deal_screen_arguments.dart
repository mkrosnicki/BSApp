import 'package:BSApp/models/comment_model.dart';

class CommentScreenArguments {
  final CommentModel comment;
  final String dealId;
  final String commentToScrollId;

  CommentScreenArguments(this.comment, this.dealId, {this.commentToScrollId});
}
