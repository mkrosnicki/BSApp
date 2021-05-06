import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/providers/auth.dart';
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
    return Consumer<Auth>(
      builder: (context, authData, child) {
        final bool wasSeen = authData.isAuthenticated &&
            notification.issuedAt.isBefore(authData.me.notificationsSeenAt);
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
          width: double.infinity,
          color: wasSeen ? Colors.white : Colors.blue.shade50,
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
                      padding: const EdgeInsets.only(
                          left: 12.0, right: 12.0, top: 6.0),
                      child: Text(
                        DateUtil.timeAgoString(notification.issuedAt),
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
      },
    );
  }
}
