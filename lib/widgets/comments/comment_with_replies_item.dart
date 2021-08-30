import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/widgets/comments/comment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentWithRepliesItem extends StatefulWidget {
  final CommentModel comment;
  final List<CommentModel> subComments;
  final String dealId;

  const CommentWithRepliesItem(this.dealId, this.comment, this.subComments);

  @override
  _CommentWithRepliesItemState createState() => _CommentWithRepliesItemState();
}

class _CommentWithRepliesItemState extends State<CommentWithRepliesItem> {
  bool showAnswers;

  bool showReplies = false;
  bool repliesLoaded = false;

  @override
  void initState() {
    showAnswers = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Comments commentsProvider = Provider.of<Comments>(context, listen: false);
    final List<CommentModel> subComments = commentsProvider.getSubCommentsOf(widget.comment.id);
    return Column(
      children: [
        CommentItem(widget.comment, widget.dealId, _toggleReplies),
        if (subComments.isNotEmpty)
          Column(
            children: commentsProvider
                .getSubCommentsOf(widget.comment.id)
                .map((reply) => CommentItem(reply, widget.dealId, null))
                .toList(),
          )
      ],
    );
  }

  Future<void> _toggleReplies() async {
    final Comments commentsProvider = Provider.of<Comments>(context, listen: false);
    if (!showReplies) {
      await commentsProvider.fetchSubCommentsForComment(widget.comment.id).then((value) {
        setState(() {
          repliesLoaded = true;
          showReplies = true;
        });
      });
    } else {
      setState(() {
        repliesLoaded = false;
        showReplies = false;
      });
    }
  }
}
