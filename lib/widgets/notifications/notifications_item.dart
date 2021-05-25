import 'package:BSApp/models/comment_screen_arguments.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/notification_type.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/comments/comment_screen.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/notifications/notification_item_content.dart';
import 'package:BSApp/widgets/notifications/notification_item_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem(this.notification);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        final bool wasSeen =
            currentUser.isAuthenticated && notification.issuedAt.isBefore(currentUser.me.notificationsSeenAt);
        return Stack(
          children: [
            GestureDetector(
              onTap: () => _navigateToSource(context),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
                width: double.infinity,
                color: wasSeen ? Colors.white : Colors.blue.shade50,
                // color: Colors.white,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: NotificationItemIcon(notification.notificationType),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NotificationItemContent(notification),
                          Container(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 6.0),
                            child: Text(
                              DateUtil.timeAgoString(notification.issuedAt),
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
            ),
            if (!wasSeen)
              Positioned(
                left: 4.0,
                top: 8.0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _navigateToSource(BuildContext context) {
    switch (notification.notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
      case NotificationType.YOUR_POST_REPLIED:
      case NotificationType.YOUR_POST_LIKED:
        _navigateToTopic(context);
        break;
      case NotificationType.YOUR_DEAL_RATED:
        _navigateToDeal(context);
        break;
      case NotificationType.YOUR_DEAL_COMMENTED:
      case NotificationType.YOUR_COMMENT_REPLIED:
      case NotificationType.YOUR_COMMENT_RATED:
        _navigateToComment(context);
        break;
      default:
      // do noting
    }
  }

  void _navigateToTopic(BuildContext context) {
    final topicsProvider = Provider.of<Topics>(context, listen: false);
    topicsProvider.fetchTopic(notification.relatedTopicId).then((_) {
      final TopicModel topic = topicsProvider.findById(notification.relatedTopicId);
      Navigator.of(context).pushNamed(TopicScreen.routeName,
          arguments: TopicScreenArguments(topic, postToScrollId: notification.relatedPostId));
    });
  }

  void _navigateToDeal(BuildContext context) {
    final dealsProvider = Provider.of<Deals>(context, listen: false);
    dealsProvider.fetchDeal(notification.relatedDealId).then((_) {
      final DealModel deal = dealsProvider.findById(notification.relatedDealId);
      Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
    });
  }

  void _navigateToComment(BuildContext context) {
    Navigator.of(context).pushNamed(CommentScreen.routeName,
        arguments: CommentScreenArguments(
            notification.relatedDealId, notification.relatedDealTitle, notification.relatedCommentId, notification.relatedParentCommentId, notification.notificationType, null));
  }
}
