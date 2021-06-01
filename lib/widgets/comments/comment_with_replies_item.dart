import 'dart:async';

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

  bool showAnswers;
  StreamSubscription subscription;

  @override
  void initState() {
    showAnswers = false;
    subscription = widget.commentToReplySubject.listen((value) {
      if (value != null && value.id == widget.comment.id) {
        _showAnswers(true);
      }
    });
    super.initState();
  }


  @override
  void didChangeDependencies() {
    // widget.dep
  }

  @override
  void dispose() {
    subscription.cancel();
    subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentItem(widget.comment, widget.dealId, widget.commentToReplySubject),
        if (!showAnswers && widget.comment.subComments.isNotEmpty) GestureDetector(
          onTap: () => showAnswers ? _showAnswers(false) : _showAnswers(true),
          child: Container(
            padding: const EdgeInsets.only(left: 50.0, top: 4.0, bottom: 6.0),
            width: double.infinity,
            color: Colors.white,
            child: Text(
              showAnswers ? '' : 'Pokaż odpowiedzi (${widget.comment.subComments.length})',
              style: const TextStyle(fontSize: 11, color: Colors.blueAccent),
            ),
          ),
        ),
        if (showAnswers) Column(
          children: widget.comment.subComments
              .map((reply) => CommentItem(reply, widget.dealId, widget.commentToReplySubject))
              .toList(),
        ),
      ],
    );
  }

  void _showAnswers(bool show) {
    setState(() {
      showAnswers = show;
    });
  }
}
