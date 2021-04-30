import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/notification_type.dart';
import 'package:flutter/material.dart';

class NotificationItemContent extends StatelessWidget {

  final NotificationModel notification;

  NotificationItemContent(this.notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            notificationTitle,
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              notificationSubtitle,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get notificationTitle {
    switch (notification.notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} inni napisali post w Twoim temacie'
            : '${notification.mainIssuerUsername} napisał(a) post w Twoim temacie';
        break;
      case NotificationType.YOUR_DEAL_RATED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} ocenili Twoją okazję'
            : '${notification.mainIssuerUsername} ocenił Twoją okazję';
        break;
    }
  }

  String get notificationSubtitle {
    switch (notification.notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
        return notification.relatedTopicTitle;
        break;
      case NotificationType.YOUR_DEAL_RATED:
        return notification.relatedDealTitle;
        break;
    }
  }
}
