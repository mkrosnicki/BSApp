import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:BSApp/util/fake_data_provider.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:BSApp/widgets/forum/post_item_heart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItemUserInfoNew extends StatelessWidget {
  final PostModel post;

  const PostItemUserInfoNew(this.post);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle =
        const TextStyle(fontSize: 11, color: Colors.black54, height: 1.4);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          UserAvatar(
            username: post.adderInfo.username,
            imagePath: FakeDataProvider.USER_AVATAR_PATH,
            radius: 15,
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(left: 4.0),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () => _navigateToUserProfileScreen(
                                  context, post.adderInfo.id),
                              child: Text(
                                post.adderInfo.username,
                                style: TextStyle(
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
                      PostItemHeartButton(post),
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

  _navigateToUserProfileScreen(BuildContext context, String userId) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: userId);
  }
}
