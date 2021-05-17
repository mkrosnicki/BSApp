import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/comments/comment_item_likes_string.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommentItemBottomSection extends StatelessWidget {
  final CommentModel comment;
  final PublishSubject<CommentModel> commentToReplySubject;

  const CommentItemBottomSection(this.comment, this.commentToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 42.0, top: 4.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Text(
                DateUtil.timeAgoString(comment.addedAt),
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 11, color: Colors.grey),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 11, color: Colors.grey),
                ),
              ),
              CommentItemLikesString(comment.id),
            ],
          ),
          InkWell(
            onTap: () => _startCommentReply(comment),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Odpowiedz',
                style: TextStyle(fontSize: 12, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _startCommentReply(CommentModel comment) {
    commentToReplySubject.add(comment);
  }
}
