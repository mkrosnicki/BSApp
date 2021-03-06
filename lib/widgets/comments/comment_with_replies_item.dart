import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/comments/comment_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
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

  bool _showReplies = false;
  bool _loadingReplies = false;

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
        if (_loadingReplies)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: JumpingDotsProgressIndicator(
              fontSize: 30.0,
              color: MyColorsProvider.DEEP_BLUE,
            ),
          ),
        if (subComments.isNotEmpty && _showReplies)
          Column(
            children: commentsProvider
                .getSubCommentsOf(widget.comment.id)
                .map((reply) => CommentItem(reply, widget.dealId, null))
                .toList(),
          )
      ],
    );
  }

  Future<bool> _toggleReplies() async {
    final Comments commentsProvider = Provider.of<Comments>(context, listen: false);
    if (!_showReplies) {
      setState(() {
        _loadingReplies = true;
      });
      await commentsProvider.fetchSubCommentsForComment(widget.comment.id).then((value) {
        setState(() {
          _loadingReplies = false;
          _showReplies = true;
        });
      });
    } else {
      setState(() {
        _loadingReplies = false;
        _showReplies = false;
      });
    }
    return _showReplies;
  }
}
