import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    return Column(
      children: [
        _buildComment(context, widget.comment),
        Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Column(
            children: widget.comment.subComments
                .map((reply) => _buildComment(context, reply))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildComment(BuildContext context, CommentModel comment) {
    var userInfoTextStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            comment.adderInfo.username,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${_dateFormat.format(comment.adderInfo.registeredAt)}',
                              style: userInfoTextStyle,
                            ),
                            Text(
                              ' • ',
                              style: userInfoTextStyle,
                            ),
                            Text(
                              'Okazje: ${comment.adderInfo.addedDeals}',
                              style: userInfoTextStyle,
                            ),
                            Text(
                              ' • ',
                              style: userInfoTextStyle,
                            ),
                            Text(
                              'Komentarze: ${comment.adderInfo.addedComments}',
                              style: userInfoTextStyle,
                            ),
                          ],
                        ),
                      ],
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
              if (comment.parentId == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Provider.of<DealReplyState>(context, listen: false)
                              .startCommentReply(comment.id),
                      child: Text(
                        'Odpowiedz',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
