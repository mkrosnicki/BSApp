import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/models/activity_type.dart';
import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/comment_screen_arguments.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/comments/comment_screen.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
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
import 'package:provider/provider.dart';

import 'comment_replied_activity_content.dart';
import 'comment_replied_icon.dart';

class ActivityItem extends StatelessWidget {
  final ActivityModel activity;

  const ActivityItem(this.activity);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSource(context),
      child: Container(
        margin: MyStylingProvider.ITEMS_MARGIN,
        decoration: MyStylingProvider.ITEMS_BORDER.copyWith(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
        width: double.infinity,
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
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0),
                    child: Text(
                      DateUtil.timeAgoString(activity.issuedAt),
                      style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.1),
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
      ),
    );
  }

  Widget _buildActivityContent() {
    Widget content;
    switch (activity.activityType) {
      case ActivityType.TOPIC_CREATED:
        content = TopicCreatedActivityContent(activity.issuedByUsername, activity.relatedTopicTitle);
        break;
      case ActivityType.DEAL_CREATED:
        content = DealCreatedActivityContent(activity.issuedByUsername, activity.relatedDealTitle);
        break;
      case ActivityType.POST_ADDED:
        content = PostAddedActivityContent(activity.issuedByUsername, activity.relatedTopicTitle);
        break;
      case ActivityType.COMMENT_ADDED:
        content = CommentAddedActivityContent(activity.issuedByUsername, activity.relatedDealTitle);
        break;
      case ActivityType.COMMENT_REPLIED:
        content = CommentRepliedActivityContent(activity.issuedByUsername, activity.relatedDealTitle);
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
      case ActivityType.COMMENT_REPLIED:
        icon = const CommentRepliedIcon();
        break;
      default:
        icon = null;
    }
    return icon;
  }

  void _navigateToSource(BuildContext context) {
    switch (activity.activityType) {
      case ActivityType.POST_ADDED:
      case ActivityType.TOPIC_CREATED:
        _navigateToTopic(context);
        break;
      case ActivityType.DEAL_CREATED:
        _navigateToDeal(context);
        break;
      case ActivityType.COMMENT_ADDED:
      case ActivityType.COMMENT_REPLIED:
        _navigateToComment(context);
        break;
      default:
      // do noting
    }
  }

  void _navigateToTopic(BuildContext context) {
    final topicsProvider = Provider.of<Topics>(context, listen: false);
    topicsProvider.fetchTopic(activity.relatedTopicId).then((_) {
      final TopicModel topic = topicsProvider.findById(activity.relatedTopicId);
      Navigator.of(context).pushNamed(TopicScreen.routeName,
          arguments: TopicScreenArguments(topic,
              postToScrollId: activity.relatedPostId));
    });
  }

  void _navigateToDeal(BuildContext context) {
    final dealsProvider = Provider.of<Deals>(context, listen: false);
    dealsProvider.fetchDeal(activity.relatedDealId).then((_) {
      final DealModel deal = dealsProvider.findById(activity.relatedDealId);
      Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
    });
  }

  void _navigateToComment(BuildContext context) {
    Navigator.of(context).pushNamed(
      CommentScreen.routeName,
      arguments: CommentScreenArguments(activity.relatedDealId, activity.relatedDealTitle,
          activity.relatedCommentId, activity.relatedCommentParentId, null, activity.activityType),
      // arguments: CommentScreenArguments(
      //   activity.relatedDealId,
      //   activity.relatedDealTitle,
      //   isParent ? null : activity.relatedCommentId,
      //   isParent ? activity.relatedCommentId : activity.relatedCommentParentId,
      //   null,
      //   activity.activityType,
      // ),
    );
  }
}
