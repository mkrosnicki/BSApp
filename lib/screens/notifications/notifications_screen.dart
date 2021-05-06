import 'package:BSApp/providers/current_user_info.dart';
import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/notifications/notifications_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'clear_notifications_button.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/nofifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Powiadomienia',
        actions: [
          ClearNotificationsButton()
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<CurrentUserInfo>(context, listen: false)
              .fetchMyNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: const LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: const ServerErrorSplash(),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refreshNotifications(context),
                  child: Consumer<CurrentUserInfo>(
                    builder: (context, myInfo, child) {
                      if (myInfo.myNotifications.isEmpty) {
                        return _buildNoNotificationsSplashView();
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) => NotificationItem(
                              myInfo.myNotifications[index]),
                          itemCount: myInfo.myNotifications.length,
                        );
                      }
                    },
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  _buildNoNotificationsSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: const Text(
          'Nie masz żadnych powiadomień',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }

  _refreshNotifications(BuildContext context) {}
}
