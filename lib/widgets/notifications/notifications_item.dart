import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/notification_type.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/notifications/your_topic_replied_icon.dart';
import 'package:BSApp/widgets/notifications/your_topic_replied_notification_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  NotificationItem(this.notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
      width: double.infinity,
      color: Colors.white,
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
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
                    '${DateUtil.timeAgoString(notification.issuedAt)}',
                    style: TextStyle(
                        fontSize: 11, color: Colors.black54, height: 1.1),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              CupertinoIcons.chevron_right,
              color: MyColorsProvider.DEEP_BLUE,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  _buildActivityContent() {
    Widget content;
    switch (notification.notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
        content = YourTopicRepliedNotificationContent(
            notification.mainIssuerUsername,
            notification.relatedTopicTitle,
            notification.totalNumberOfIssuers);
        break;
      default:
        content = null;
    }
    return content;
  }

  _buildActivityIcon() {
    Widget icon;
    switch (notification.notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
        icon = const YourTopicRepliedIcon();
        break;
      default:
        icon = null;
    }
    return icon;
  }
}
