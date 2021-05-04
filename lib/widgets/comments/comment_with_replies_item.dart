import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/widgets/comments/comment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommentWithRepliesItem extends StatefulWidget {
  final CommentModel comment;
  final String dealId;
  final PublishSubject<CommentModel> commentToReplySubject;

  CommentWithRepliesItem(this.dealId, this.comment, this.commentToReplySubject);

  @override
  _CommentWithRepliesItemState createState() => _CommentWithRepliesItemState();
}

class _CommentWithRepliesItemState extends State<CommentWithRepliesItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CommentItem(widget.comment, widget.dealId, widget.commentToReplySubject),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              children: widget.comment.subComments
                  .map((reply) => CommentItem(reply, widget.dealId, widget.commentToReplySubject))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
