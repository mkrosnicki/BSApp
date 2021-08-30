import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/reply_state.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemBottomSection extends StatelessWidget {
  final CommentModel comment;
  final Function toggleReplies;

  const CommentItemBottomSection(this.comment, this.toggleReplies);

  @override
  Widget build(BuildContext context) {
    final ReplyState replyState = Provider.of<ReplyState>(context, listen: false);
    final Comments commentsProvider = Provider.of<Comments>(context, listen: false);
    final List<CommentModel> subComments = commentsProvider.getSubCommentsOf(comment.id);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 4.0),
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
              if (toggleReplies != null && _areSubCommentsPresentAndLoaded(subComments))
                GestureDetector(
                  onTap: () => toggleReplies(),
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Text(
                      'Pokaż odpowiedzi (${comment.subCommentsCount})',
                      style: const TextStyle(fontSize: 11, color: Colors.blue),
                    ),
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () => _startCommentReply(comment, replyState),
            behavior: HitTestBehavior.translucent,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
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

  bool _areSubCommentsPresentAndLoaded(final List<CommentModel> subComments) {
    return comment.hasSubComments && subComments.isEmpty;
  }
}
