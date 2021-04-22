import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
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
    var textStyle = Theme.of(context)
        .textTheme
        .bodyText2
        .copyWith(fontSize: 11, color: Colors.black38);
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        UserAvatar(username: comment.adderInfo.username, radius: 18,),
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
                    Text(
                      // '${_dateFormat.format(comment.addedAt)}',
                      '${DateUtil.timeAgoString(comment.addedAt)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '${comment.adderInfo.addedDeals}',
                      style: textStyle,
                    ),
                    Text(
                      ' okazje',
                      style: textStyle,
                    ),
                    Text(
                      ' • ',
                      style: textStyle,
                    ),
                    Text(
                      '${comment.adderInfo.addedComments}',
                      style: textStyle,
                    ),
                    Text(
                      ' komentarz(e)',
                      style: textStyle,
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
