import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/my_border_icon_button.dart';
import 'package:BSApp/widgets/deals/comment_item_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          _buildComment(context, widget.comment),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
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
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentItemUserInfo(comment),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 16.0),
                  child: Wrap(
                    children: [
                      if (_displayRepliedUsername(comment))
                        Text(
                          '@${comment.replyForUsername} ',
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                        ),
                      Text(
                        comment.content,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<Auth>(
                builder: (context, authData, child) => Consumer<Comments>(
                  builder: (context, commentsData, child) => Container(
                    width: double.infinity,
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: [
                            MyBorderIconButton(
                              iconData: CupertinoIcons.hand_thumbsdown_fill,
                              function: () => _voteForComment(widget.dealId,
                                  comment.id, false, authData.isAuthenticated),
                              trailing:
                                  comment.numberOfNegativeVotes.toString(),
                              color: Colors.red,
                              isActive: commentsData.wasVotedNegativelyBy(
                                  comment.id, authData.userId),
                              showBorder: false,
                              fontSize: 13,
                            ),
                            MyBorderIconButton(
                              iconData: CupertinoIcons.hand_thumbsup_fill,
                              function: () => _voteForComment(widget.dealId,
                                  comment.id, true, authData.isAuthenticated),
                              trailing:
                                  comment.numberOfPositiveVotes.toString(),
                              color: MyColorsProvider.GREEN,
                              isActive: commentsData.wasVotedPositivelyBy(
                                  comment.id, authData.userId),
                              showBorder: false,
                              fontSize: 13,
                            ),
                          ],
                        ),
                        MyBorderIconButton(
                            label: 'Odpowiedz',
                            function: () => _startCommentReply(comment),
                            color: Colors.blue,
                            isBold: true,
                            fontSize: 12,
                            showBorder: false,
                            isActive: true),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  _voteForComment(
      String dealId, String commentId, bool isPositive, isAuthenticated) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      Provider.of<Comments>(context, listen: false)
          .voteForComment(dealId, commentId, isPositive);
    }
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
