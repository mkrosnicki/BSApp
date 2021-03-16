import 'package:BSApp/models/comment-mode.dart';
import 'package:BSApp/models/comment-model.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final Function setCommentModeFunction;

  CommentItem(this.comment, this.setCommentModeFunction);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.network(
                    'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg'),
              ),
              Text(comment.username),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
            child: Text(comment.content),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => setCommentModeFunction(CommentMode.REPLY_COMMENT, commentToReplyId: comment.id),
                child: Text(
                  'Odpowiedz',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _replyToComment() {}
}
