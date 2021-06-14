import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:BSApp/widgets/forum/post_item_admin_actions_button.dart';
import 'package:BSApp/widgets/forum/post_item_heart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostItemUserInfo extends StatelessWidget {
  final PostModel post;

  const PostItemUserInfo(this.post);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle = TextStyle(fontSize: 11, color: Colors.black54, height: 1.4);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          UserAvatar(
            username: post.adderInfo.username,
            image: post.adderInfo.avatar,
            imagePath: post.adderInfo.imagePath,
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
                              onTap: () => _navigateToUserProfileScreen(context, post.adderInfo.id),
                              child: Text(
                                post.adderInfo.username,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '${post.adderInfo.addedPosts + post.adderInfo.addedTopics} ${ConjugationHelper.postsConjugation(post.adderInfo.addedPosts + post.adderInfo.addedTopics)}',
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
                              return currentUser.isAdmin ? PostItemAdminActionsButton(post) : Container();
                            },
                          ),
                          PostItemHeartButton(post),
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
    Navigator.of(context).pushNamed(UserProfileScreen.routeName, arguments: userId);
  }
}
