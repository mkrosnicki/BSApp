import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/reply_state.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/comments/comment_item_likes_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemBottomSection extends StatelessWidget {
  final CommentModel comment;

  const CommentItemBottomSection(this.comment);

  @override
  Widget build(BuildContext context) {
    final ReplyState replyState = Provider.of<ReplyState>(context, listen: false);
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
            onTap: () => _startCommentReply(comment, replyState),
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

  void _startCommentReply(final CommentModel comment, final ReplyState replyState) {
    replyState.setCommentToReply(comment);
  }
}
