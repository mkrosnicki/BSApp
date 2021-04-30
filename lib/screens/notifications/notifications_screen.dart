import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/notifications/notifications_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/nofifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Powiadomienia',
        actions: [
          // const AppBarCloseButton(Colors.black),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<Notifications>(context, listen: false)
              .fetchMyNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Flexible(
                  child: RefreshIndicator(
                    onRefresh: () => _refreshNotifications(context),
                    child: Consumer<Notifications>(
                      builder: (context, notificationsData, child) =>
                          ListView.builder(
                        itemBuilder: (context, index) => NotificationItem(notificationsData.myNotifications[index]),
                        itemCount: notificationsData.myNotifications.length,
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  _refreshNotifications(BuildContext context) {}
}
