import 'package:BSApp/models/comment-model.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {

  final CommentModel comment;
  final Function callbackFunction;

  CommentItem(this.comment, this.callbackFunction);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(comment.username),
        Text(comment.content),
      ],
    );
  }
}
