import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/screens/comments/comment_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class CommentItemContent extends StatelessWidget {
  final CommentModel comment;

  const CommentItemContent(this.comment);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsets.only(left: 4.0),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 2.0),
              child: GestureDetector(
                onTap: () {
                  if (comment.adderInfo != null) {
                    _navigateToUserProfileScreen(context, comment.adderInfo.id);
                  }
                },
                child: Text(
                  comment.adderName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  if (_displayRepliedUsername(comment))
                    Text(
                      '@${comment.repliedUsername != null ? comment.repliedUsername : 'Usunięty użytkownik'} ',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        height: 1.3,
                      ),
                    ),
                  Text(
                    comment.content,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _displayRepliedUsername(CommentModel comment) {
    return !_isReplyToParent(comment) && comment.quote != null;
  }

  bool _isReplyToParent(CommentModel comment) {
    return comment.parentId == comment.repliedId;
  }

  void _navigateToUserProfileScreen(BuildContext context, String userId) {
    if (ModalRoute.of(context).settings.name == CommentScreen.routeName) {
      Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName, arguments: userId);
    } else {
      Navigator.of(context).pushNamed(UserProfileScreen.routeName, arguments: userId);
    }
  }
}
