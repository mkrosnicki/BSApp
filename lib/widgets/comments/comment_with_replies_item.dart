
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
  void didChangeDependencies() {
    // widget.dep
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Comments commentsProvider = Provider.of<Comments>(context, listen: false);
    final List<CommentModel> subComments = commentsProvider.getSubCommentsOf(widget.comment.id);
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          CommentItem(widget.comment, widget.dealId),
          if (widget.comment.hasSubComments && !showReplies) GestureDetector(
            // onTap: () => subComments.isNotEmpty ? _showAnswers(false) : _showAnswers(true),
            onTap: () => !showReplies ? _showReplies(commentsProvider, true) : _showReplies(commentsProvider, false),
            child: Container(
              padding: const EdgeInsets.only(left: 50.0, top: 4.0, bottom: 6.0),
              width: double.infinity,
              color: Colors.white,
              child: widget.comment.hasSubComments ? Text(
                'Pokaż odpowiedzi (${widget.comment.subCommentsCount})',
                style: const TextStyle(fontSize: 11, color: Colors.blueAccent),
              ) : Container(),
            ),
          ),
          // if (!subComments.isNotEmpty) Column(
          //   children: widget.subComments
          //       .map((reply) => CommentItem(reply, widget.dealId, widget.commentToReplySubject))
          //       .toList(),
          // ),
          if (showReplies && repliesLoaded) Column(
            children: commentsProvider.getSubCommentsOf(widget.comment.id)
                .map((reply) => CommentItem(reply, widget.dealId))
                .toList(),
          )
        ],
      ),
    );
  }

  void _showAnswers(bool show) {
    setState(() {
      showAnswers = show;
    });
  }

  void _showReplies(final Comments commentsProvider, final bool show) async {
    if (show) {
      await commentsProvider.fetchSubCommentsForComment(widget.comment.id).then((value) {
        setState(() {
          repliesLoaded = true;
          showReplies = show;
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
