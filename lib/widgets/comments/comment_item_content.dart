import 'package:BSApp/models/comment_model.dart';
import 'package:flutter/material.dart';

class CommentItemContent extends StatelessWidget {
  final CommentModel comment;

  const CommentItemContent(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: const EdgeInsets.only(left: 4.0),
      child: Row(
        children: [
          if (_displayRepliedUsername(comment))
            Text(
              '@${comment.repliedUsername ?? 'Usunięty użytkownik'} ',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                height: 1.3,
              ),
            ),
          Text(
            comment.content,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  bool _displayRepliedUsername(CommentModel comment) {
    return !_isReplyToParent(comment) && comment.quote != null;
  }

  bool _isReplyToParent(CommentModel comment) {
    return comment.parentId == comment.repliedId;
  }
}
