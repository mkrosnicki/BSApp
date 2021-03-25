import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/my_border_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentItem extends StatefulWidget {
  final CommentModel comment;

  CommentItem(this.comment);

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
        Padding(
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
                    width: 60,
                    height: 60,
                    child: Image.network(
                        'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg'),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
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
                                child: Text(
                                  comment.adderInfo.username,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                '${_dateFormat.format(comment.addedAt)}',
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(
                  comment.content,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              // if (comment.parentId == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButtonWithPaddings(label: 'Nie lubię', iconData: CupertinoIcons.hand_thumbsdown_fill, function: () => _startCommentReply(comment.id), trailing: '6', color: Colors.red),
                    _buildButtonWithPaddings(label: 'Lubię', iconData: CupertinoIcons.hand_thumbsup_fill, function: () => _startCommentReply(comment.id), trailing: '6', color: MyColorsProvider.GREEN, isActive: true),
                    _buildButtonWithPaddings(label: 'Odpowiedz', iconData: CupertinoIcons.reply_thick_solid, function: () => _startCommentReply(comment.id), color: Colors.blue, isActive: true),
                  ],
                )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  _buildButtonWithPaddings({String label, IconData iconData, Function function, String trailing, bool isActive = false, Color color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: MyBorderIconButton(label: label, iconData: iconData, function: function, trailing: trailing, isActive: isActive, color: color),
      ),
    );
  }

  _startCommentReply(String commentId) {
    Provider.of<DealReplyState>(context, listen: false)
        .startCommentReply(commentId);
  }
}
