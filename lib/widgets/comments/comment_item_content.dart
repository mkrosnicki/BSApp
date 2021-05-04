import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:flutter/material.dart';

class CommentItemContent extends StatelessWidget {

  final CommentModel comment;


  CommentItemContent(this.comment);

  @override
  Widget build(BuildContext context) {
    return         Flexible(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.only(left: 4.0),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2.0),
              child: GestureDetector(
                onTap: () => _navigateToUserProfileScreen(
                    context, comment.adderInfo.id),
                child: Text(
                  comment.adderInfo.username,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                if (_displayRepliedUsername(comment))
                  Text(
                    '@${comment.replyForUsername} ',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      height: 1.3,
                    ),
                  ),
                Text(
                  longer(comment.content),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _displayRepliedUsername(CommentModel comment) {
    return !_isReplyToParent(comment) && comment.replyForUsername != null;
  }

  bool _isReplyToParent(CommentModel comment) {
    return comment.parentId == comment.replyForId;
  }

  _navigateToUserProfileScreen(BuildContext context, String userId) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: userId);
  }

  String longer(String text) {
    String ret = '';
    for (int i = 0; i < 15; i++) {
      ret = ret + text + ' ';
    }
    return ret;
  }
}
