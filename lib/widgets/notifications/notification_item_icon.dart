import 'package:BSApp/models/notification_type.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationItemIcon extends StatelessWidget {
  final NotificationType notificationType;

  NotificationItemIcon(this.notificationType);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 20,
      maxRadius: 20,
      foregroundColor: Colors.white,
      backgroundColor: iconColor,
      child: Icon(iconData),
    );
  }

  IconData get iconData {
    switch (notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
        return CupertinoIcons.bubble_left;
        break;
      case NotificationType.YOUR_DEAL_RATED:
        return CupertinoIcons.plus_slash_minus;
        break;
    }
  }

  Color get iconColor {
    switch (notificationType) {
      case NotificationType.YOUR_TOPIC_REPLIED:
        return Colors.deepOrangeAccent;
        break;
      case NotificationType.YOUR_TOPIC_REPLIED:
        return MyColorsProvider.BLUE;
        break;
    }
  }
}
