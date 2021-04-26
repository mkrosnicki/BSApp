import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/models/activity_type.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/activities/topic_created_activity_content.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;

  ActivityItem(this.activity);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      width: double.infinity,
      color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: UserAvatar(
              username: activity.issuedByUsername,
              radius: 20,
              backgroundColor: MyColorsProvider.BLUE,
            ),
          ),
          Flexible(
            child: _buildActivityContent(),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            alignment: Alignment.topRight,
            child: Text(
              '${DateUtil.timeAgoString(activity.issuedAt)}',
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 11, color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }

  _buildActivityContent() {
    Widget content;
    switch (activity.activityType) {
      case ActivityType.TOPIC_CREATED:
        content = TopicCreatedActivityContent(
            activity.issuedByUsername, activity.relatedTopic);
        break;
      default:
        content = null;
    }
    return content;
  }
}
