import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/models/activity_type.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/activities/comment_reply_icon.dart';
import 'package:BSApp/widgets/activities/deal_added_icon.dart';
import 'package:BSApp/widgets/activities/deal_created_activity_content.dart';
import 'package:BSApp/widgets/activities/topic_added_icon.dart';
import 'package:BSApp/widgets/activities/topic_created_activity_content.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;

  ActivityItem(this.activity);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
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
            child: _buildActivityIcon(),
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
      case ActivityType.DEAL_CREATED:
        content = DealCreatedActivityContent(activity.issuedByUsername, activity.relatedDeal);
        break;
      default:
        content = null;
    }
    return content;
  }

  _buildActivityIcon() {
    Widget icon;
    switch (activity.activityType) {
      case ActivityType.TOPIC_CREATED:
        icon = const TopicAddedIcon();
        break;
      case ActivityType.DEAL_CREATED:
        icon = const DealAddedIcon();
        break;
      default:
        icon = null;
    }
    return icon;
  }

}
