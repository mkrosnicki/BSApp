import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class CommentItemUserInfo extends StatelessWidget {
  final CommentModel comment;

  const CommentItemUserInfo(this.comment);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    const userInfoBoldTextStyle = const TextStyle(
        fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold);
    return Flex(
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
                            context, comment.adderInfo.id),
                        child: Text(
                          comment.adderInfo.username,
                          style: const TextStyle(
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
                    const Text(
                      ' okazje',
                      style: userInfoTextStyle,
                    ),
                    const Text(
                      ' • ',
                      style: userInfoTextStyle,
                    ),
                    Text(
                      '${comment.adderInfo.addedComments}',
                      style: userInfoBoldTextStyle,
                    ),
                    const Text(
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
    );
  }

  _navigateToUserProfileScreen(BuildContext context, String userId) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: userId);
  }
}
