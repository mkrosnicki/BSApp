import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicItemUserInfo extends StatelessWidget {
  final TopicModel topic;

  const TopicItemUserInfo(this.topic);

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
        CircleAvatar(
          minRadius: 10,
          maxRadius: 10,
          backgroundImage: NetworkImage(
            'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg',
          ),
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
                    Container(
                      margin: EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: () => _navigateToUserProfileScreen(
                            context, topic.adderInfo.id),
                        child: Text(
                          topic.adderInfo.username,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ),
                    ),
                    const Icon(CupertinoIcons.chevron_down, size: 16, color: Colors.black54,),
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
