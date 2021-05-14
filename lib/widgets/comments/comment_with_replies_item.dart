import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/widgets/comments/comment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommentWithRepliesItem extends StatefulWidget {
  final CommentModel comment;
  final String dealId;
  final PublishSubject<CommentModel> commentToReplySubject;

  const CommentWithRepliesItem(this.dealId, this.comment, this.commentToReplySubject);

  @override
  _CommentWithRepliesItemState createState() => _CommentWithRepliesItemState();
}

class _CommentWithRepliesItemState extends State<CommentWithRepliesItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentItem(widget.comment, widget.dealId, widget.commentToReplySubject),
        Column(
          children: widget.comment.subComments
              .map((reply) => CommentItem(reply, widget.dealId, widget.commentToReplySubject))
              .toList(),
        ),
      ],
    );
  }
}
