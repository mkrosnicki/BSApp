import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/login_to_continue_splash.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/notifications/notifications_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'clear_notifications_button.dart';

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/nofifications';

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  Notifications _notifications;
  CurrentUser _currentUser;

  @override
  Widget build(BuildContext context) {
    _notifications = Provider.of<Notifications>(context, listen: false);
    _currentUser = Provider.of<CurrentUser>(context, listen: false);
    return Consumer<CurrentUser>(builder: (context, currentUser, child) {
      return Scaffold(
        appBar: BaseAppBar(
          title: 'Powiadomienia',
          actions: [
            if (currentUser.isAuthenticated) ClearNotificationsButton(),
          ],
        ),
        body: SafeArea(
          child: currentUser.isAuthenticated
              ? FutureBuilder(
                  future: _notifications.fetchMyNotifications(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LoadingIndicator());
                    } else {
                      if (snapshot.error != null) {
                        return const Center(
                          child: ServerErrorSplash(),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () => _refreshNotifications(context),
                          child: Consumer<Notifications>(
                            builder: (context, notificationsData, child) {
                              if (notificationsData.myNotifications.isEmpty) {
                                return _buildNoNotificationsSplashView();
                              } else {
                                return ListView.builder(
                                  itemBuilder: (context, index) =>
                                      NotificationItem(notificationsData.myNotifications[index]),
                                  itemCount: notificationsData.myNotifications.length,
                                );
                              }
                            },
                          ),
                        );
                      }
                    }
                  },
                )
              : const LoginToContinueSplash('Zaloguj się, aby zobaczyć\n swoje powiadomienia'),
        ),
      );
    });
  }

  Widget _buildNoNotificationsSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nie masz żadnych powiadomień',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }

  Future<void> _refreshNotifications(BuildContext context) async {
    await _notifications.fetchMyNotifications();
  }

  @override
  void deactivate() {
    Future.delayed(Duration.zero, () {
      _currentUser.updateNotificationsTimestamp();
      _notifications.updateNotificationsTimestamp();
    });
    super.deactivate();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
    });
    super.initState();
  }
}
