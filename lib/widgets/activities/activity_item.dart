import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/models/activity_type.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/activities/comment_added_activity_content.dart';
import 'package:BSApp/widgets/activities/comment_added_icon.dart';
import 'package:BSApp/widgets/activities/deal_added_icon.dart';
import 'package:BSApp/widgets/activities/deal_created_activity_content.dart';
import 'package:BSApp/widgets/activities/post_added_activity_content.dart';
import 'package:BSApp/widgets/activities/post_added_icon.dart';
import 'package:BSApp/widgets/activities/topic_added_icon.dart';
import 'package:BSApp/widgets/activities/topic_created_activity_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;

  const ActivityItem(this.activity);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      width: double.infinity,
      color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: _buildActivityIcon(),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildActivityContent(),
                Container(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0),
                  child: Text(
                    DateUtil.timeAgoString(activity.issuedAt),
                    style: const TextStyle(
                        fontSize: 11, color: Colors.black54, height: 1.1),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4.0),
            child: const Icon(
              CupertinoIcons.chevron_right,
              color: MyColorsProvider.DEEP_BLUE,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityContent() {
    Widget content;
    switch (activity.activityType) {
      case ActivityType.TOPIC_CREATED:
        content = TopicCreatedActivityContent(
            activity.issuedByUsername, activity.relatedTopic);
        break;
      case ActivityType.DEAL_CREATED:
        content = DealCreatedActivityContent(
            activity.issuedByUsername, activity.relatedDeal);
        break;
      case ActivityType.POST_ADDED:
        content = PostAddedActivityContent(
            activity.issuedByUsername, activity.relatedTopic);
        break;
      case ActivityType.COMMENT_ADDED:
        content = CommentAddedActivityContent(
            activity.issuedByUsername, activity.relatedDeal);
        break;
      default:
        content = null;
    }
    return content;
  }

  Widget _buildActivityIcon() {
    Widget icon;
    switch (activity.activityType) {
      case ActivityType.TOPIC_CREATED:
        icon = const TopicAddedIcon();
        break;
      case ActivityType.DEAL_CREATED:
        icon = const DealAddedIcon();
        break;
      case ActivityType.POST_ADDED:
        icon = const PostAddedIcon();
        break;
      case ActivityType.COMMENT_ADDED:
        icon = const CommentAddedIcon();
        break;
      default:
        icon = null;
    }
    return icon;
  }
}
