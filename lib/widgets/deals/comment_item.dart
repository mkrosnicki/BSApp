import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;

  CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildComment(context, comment),
        Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Column(
            children: comment.subComments.map((reply) => _buildComment(context, reply))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildComment(BuildContext context, CommentModel comment) {
    return Column(
      children: [
        Padding(
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
                padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
                child: Text(comment.content),
              ),
              if (comment.parentId == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Provider.of<DealReplyState>(context, listen: false).startCommentReply(comment.id),
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
        ),
        Divider(),
      ],
    );
  }
}
