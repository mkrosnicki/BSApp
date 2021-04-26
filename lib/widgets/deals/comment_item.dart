import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/my_border_icon_button.dart';
import 'package:BSApp/widgets/deals/comment_item_user_info.dart';
import 'package:BSApp/widgets/deals/comment_item_voting_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;
  final String dealId;
  final PublishSubject<CommentModel> commentToReplySubject;

  CommentItem(this.dealId, this.comment, this.commentToReplySubject);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _buildComment(context, widget.comment),
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              children: widget.comment.subComments
                  .map((reply) => _buildComment(context, reply))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComment(BuildContext context, CommentModel comment) {
    return Container(
      // color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: Colors.white,
        border: Border.all(
          color: MyColorsProvider.GREY_BORDER_COLOR,
          width: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentItemUserInfo(comment),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
              child: Wrap(
                children: [
                  if (_displayRepliedUsername(comment))
                    Text(
                      '@${comment.replyForUsername} ',
                      style: const TextStyle(fontSize: 13, color: Colors.blue),
                    ),
                  Text(
                    comment.content,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommentItemVotingButtons(comment, widget.dealId),
                InkWell(
                  onTap: () => _startCommentReply(comment),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Odpowiedz',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _displayRepliedUsername(CommentModel comment) {
    return !_isReplyToParent(comment) && comment.replyForUsername != null;
  }

  bool _isReplyToParent(CommentModel comment) {
    return comment.parentId == comment.replyForId;
  }

  _startCommentReply(CommentModel comment) {
    widget.commentToReplySubject.add(comment);
  }
}
