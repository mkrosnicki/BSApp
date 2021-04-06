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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            minRadius: 15,
            maxRadius: 15,
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            child: Text(topic.adderInfo.username.substring(0, 1)),
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
                      Text(
                        // '${_dateFormat.format(comment.addedAt)}',
                        '${DateUtil.timeAgoString(topic.addedAt)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 11, color: Colors.black38),
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

  _navigateToUserProfileScreen(BuildContext context, String userId) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: userId);
  }
}
