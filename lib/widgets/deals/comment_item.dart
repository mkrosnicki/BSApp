import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/my_border_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;
  final String dealId;

  CommentItem(this.dealId, this.comment);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  DateFormat _dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    _dateFormat = new DateFormat.yMMMMd('pl');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          _buildComment(context, widget.comment),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
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
    var userInfoTextStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    var userInfoBoldTextStyle = const TextStyle(
        fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold);
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.only(left: 4.0),
                      child: Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6.0),
                                child: GestureDetector(
                                  onTap: () => _navigateToUserProfileScreen(
                                      comment.adderInfo.id),
                                  child: Text(
                                    comment.adderInfo.username,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                // '${_dateFormat.format(comment.addedAt)}',
                                '${DateUtil.timeAgoString(comment.addedAt)}',
                                style: userInfoTextStyle,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${comment.adderInfo.addedDeals}',
                                style: userInfoBoldTextStyle,
                              ),
                              Text(
                                ' okazje',
                                style: userInfoTextStyle,
                              ),
                              Text(
                                ' • ',
                                style: userInfoTextStyle,
                              ),
                              Text(
                                '${comment.adderInfo.addedComments}',
                                style: userInfoBoldTextStyle,
                              ),
                              Text(
                                ' komentarz(e)',
                                style: userInfoTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                        style: TextStyle(fontSize: 13),
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
                            function: () => _startCommentReply(comment.id),
                            color: Colors.blue,
                            isBold: true,
                            fontSize: 13,
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
      _showLoginScreen(context);
    } else {
      Provider.of<Comments>(context, listen: false)
          .voteForComment(dealId, commentId, isPositive);
    }
  }

  _showLoginScreen(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoginRegistrationScreen();
        },
        fullscreenDialog: true));
  }

  bool _displayRepliedUsername(CommentModel comment) {
    return !_isReplyToParent(comment) && comment.replyForUsername != null;
  }

  bool _isReplyToParent(CommentModel comment) {
    return comment.parentId == comment.replyForId;
  }

  _startCommentReply(String commentId) {
    Provider.of<DealReplyState>(context, listen: false)
        .startCommentReply(commentId);
  }

  _navigateToUserProfileScreen(String userId) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: userId);
  }
}
