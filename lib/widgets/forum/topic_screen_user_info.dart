import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicScreenUserInfo extends StatelessWidget {
  final TopicModel topicModel;

  const TopicScreenUserInfo(this.topicModel);

  @override
  Widget build(BuildContext context) {
    const userInfoTextStyle = TextStyle(fontSize: 11, color: Colors.black54, height: 1.4);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          UserAvatar(
            username: topicModel.adderName,
            image: topicModel.userAvatar,
            imagePath: topicModel.userImagePath,
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
                                if (topicModel.adderInfo != null) {
                                  _navigateToUserProfileScreen(context, topicModel.adderInfo.id);
                                }
                              },
                              child: Text(
                                topicModel.adderName,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            topicModel.adderInfo != null
                                ? '${topicModel.adderInfo.addedPosts + topicModel.adderInfo.addedTopics} ${ConjugationHelper.postsConjugation(topicModel.adderInfo.addedPosts + topicModel.adderInfo.addedTopics)}'
                                : '',
                            style: userInfoTextStyle,
                          ),
                        ],
                      ),
                      Text(
                        // '${_dateFormat.format(comment.addedAt)}',
                        DateUtil.timeAgoString(topicModel.addedAt),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 11, color: Colors.black38),
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
