import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/notification_type.dart';
import 'package:flutter/material.dart';

class NotificationItemContent extends StatelessWidget {

  final NotificationModel notification;

  const NotificationItemContent(this.notification);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notificationTitle,
            style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              notificationSubtitle,
              style: const TextStyle(
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
      case NotificationType.YOUR_DEAL_RATED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} ocenili Twoją okazję'
            : '${notification.mainIssuerUsername} ocenił(a) Twoją okazję';
        break;
      case NotificationType.YOUR_DEAL_COMMENTED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} skomentowali Twoją okazję'
            : '${notification.mainIssuerUsername} skomentował(a) Twoją okazję';
        break;
      case NotificationType.YOUR_COMMENT_RATED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername}${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} polubili Twój komentarz'
            : '${notification.mainIssuerUsername} polubił(a) Twój komentarz';
        break;
      case NotificationType.YOUR_COMMENT_REPLIED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername}${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} odpowiedzieli na Twój komentarz'
            : '${notification.mainIssuerUsername} odpowiedział(a) na Twój komentarz';
        break;
      case NotificationType.YOUR_POST_REPLIED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} odpowiedzieli na Twój post w temacie'
            : '${notification.mainIssuerUsername} odpowiedział(a) na Twój post w temacie';
        break;
      case NotificationType.YOUR_POST_LIKED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} polubili na Twój post w temacie'
            : '${notification.mainIssuerUsername} polubił(a) Twój post w temacie';
        break;
      case NotificationType.YOUR_TOPIC_REPLIED:
        return notification.totalNumberOfIssuers > 1
            ? '${notification.mainIssuerUsername} i ${notification.totalNumberOfIssuers - 1} inni napisali post w Twoim temacie'
            : '${notification.mainIssuerUsername} napisał(a) post w Twoim temacie';
        break;
      default:
        return '';
    }
  }

  String get notificationSubtitle {
    switch (notification.notificationType) {
      case NotificationType.YOUR_DEAL_RATED:
        return notification.relatedDealTitle;
        break;
      case NotificationType.YOUR_DEAL_COMMENTED:
        return notification.relatedDealTitle;
        break;
      case NotificationType.YOUR_COMMENT_RATED:
        return _shortenTo(notification.relatedCommentContent, 40);
        break;
      case NotificationType.YOUR_COMMENT_REPLIED:
        return _shortenTo(notification.relatedCommentContent, 40);
        break;
      case NotificationType.YOUR_POST_REPLIED:
        return notification.relatedTopicTitle;
        break;
      case NotificationType.YOUR_POST_LIKED:
        return notification.relatedTopicTitle;
        break;
      case NotificationType.YOUR_TOPIC_REPLIED:
        return notification.relatedTopicTitle;
        break;
      default:
        return '';
    }
  }

  String _shortenTo(String toShorten, int maxLength) {
    if (toShorten.length <= maxLength) {
      return toShorten;
    } else {
      return '${toShorten.substring(0, maxLength - 1)}...';
    }
  }
}
