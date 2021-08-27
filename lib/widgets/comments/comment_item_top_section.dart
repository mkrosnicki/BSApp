import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/comments/comment_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'comment_item_admin_actions_button.dart';
import 'comment_item_heart_button.dart';

class CommentItemTopSection extends StatelessWidget {
  final CommentModel comment;
  final String dealId;

  const CommentItemTopSection(this.comment, this.dealId);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle = TextStyle(fontSize: 11, color: Colors.black54, height: 1.5);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          UserAvatar(
            username: comment.adderName,
            image: comment.userAvatar,
            imagePath: comment.userImagePath,
            radius: 15,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(left: 4.0),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
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
                          Text(
                            comment.adderInfo != null
                                ? '${comment.adderInfo.addedComments} ${ConjugationHelper.commentsConjugation(comment.adderInfo.addedComments)}'
                                : '',
                            style: userInfoTextStyle,
                          ),
                        ],
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Consumer<CurrentUser>(
                            builder: (context, currentUser, child) {
                              return currentUser.isAdmin ? CommentItemAdminActionsButton(comment) : Container();
                            },
                          ),
                          CommentItemHeartButton(dealId, comment.id),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToUserProfileScreen(BuildContext context, String userId) {
    if (ModalRoute.of(context).settings.name == CommentScreen.routeName) {
      Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName, arguments: userId);
    } else {
      Navigator.of(context).pushNamed(UserProfileScreen.routeName, arguments: userId);
    }
  }
}
