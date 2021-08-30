import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/reply_state.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemBottomSection extends StatefulWidget {
  final CommentModel comment;
  final Function toggleReplies;

  const CommentItemBottomSection(this.comment, this.toggleReplies);

  @override
  _CommentItemBottomSectionState createState() => _CommentItemBottomSectionState();
}

class _CommentItemBottomSectionState extends State<CommentItemBottomSection> {

  bool _repliesShown = false;

  @override
  Widget build(BuildContext context) {
    final ReplyState replyState = Provider.of<ReplyState>(context, listen: false);
    final Comments commentsProvider = Provider.of<Comments>(context, listen: false);
    final List<CommentModel> subComments = commentsProvider.getSubCommentsOf(widget.comment.id);
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
                DateUtil.timeAgoString(widget.comment.addedAt),
                style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 11, color: Colors.grey),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 11, color: Colors.grey),
                ),
              ),
              if (widget.toggleReplies != null && _areSubCommentsPresentAndLoaded(subComments))
                GestureDetector(
                  onTap: () async {
                    final bool repliesShown = await widget.toggleReplies();
                    setState(() {
                      _repliesShown = repliesShown;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                    child: Text(
                      _repliesShown ? 'Schowaj odpowiedzi (${widget.comment.subCommentsCount})' : 'Pokaż odpowiedzi (${widget.comment.subCommentsCount})',
                      style: const TextStyle(fontSize: 11, color: Colors.blue),
                    ),
                  ),
                ),
            ],
          ),
          GestureDetector(
            onTap: () => _startCommentReply(widget.comment, replyState),
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
    return widget.comment.hasSubComments;
  }
}
