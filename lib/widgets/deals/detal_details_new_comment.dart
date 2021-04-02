import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsNewComment extends StatefulWidget {
  final String dealId;
  final ReplyState replyState;
  final String commentToReplyId;

  DealDetailsNewComment(this.dealId, this.replyState, this.commentToReplyId);

  @override
  _DealDetailsNewCommentState createState() => _DealDetailsNewCommentState();
}

class _DealDetailsNewCommentState extends State<DealDetailsNewComment> {
  var _commentText = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: widget.replyState == ReplyState.REPLY_DEAL
                      ? 'Napisz komentarz'
                      : 'Napisz odpowiedź',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _commentText = value;
                  });
                },
              ),
            ),
            Consumer<Auth>(
              builder: (context, authData, child) {
                bool isUserLoggedIn = authData.isAuthenticated;
                return FlatButton(
                  onPressed: () => _addReply(isUserLoggedIn),
                  child: Text('Wyślij'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _addReply(bool isUserLoggedIn) async {
    if (_commentText.trim().isEmpty) {
      return null;
    }
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      return widget.replyState == ReplyState.REPLY_DEAL
          ? _addCommentToDeal()
          : _addReplyToComment();
    }
  }

  _addReplyToComment() async {
    await Provider.of<Comments>(context, listen: false).addReplyToComment(
        widget.dealId, widget.commentToReplyId, _commentText);
    Provider.of<DealReplyState>(context, listen: false).reset();
  }

  _addCommentToDeal() async {
    await Provider.of<Comments>(context, listen: false)
        .addCommentToDeal(widget.dealId, _commentText);
    Provider.of<DealReplyState>(context, listen: false).reset();
  }
}
