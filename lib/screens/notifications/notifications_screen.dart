import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/nofifications';

  @override
  Widget build(BuildContext context) {
    // Future<StompClient> client = customStomp
    //     .connect('ws://192.168.162.241:8080/ws',
    //         onConnect: (StompClient client, Map<String, String> headers) {
    //   print(client.heartbeat);
    //   client.subscribeJson('1', '/topics/notifications/1', (headers, message) {
    //     print(message);
    //   });
    // }, onFault: (StompClient client, error, stackTrace) {
    //   print('error');
    //   print(error);
    //   print('stackTrace');
    //   print(stackTrace);
    // });
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Powiadomienia',
        actions: [
          // const AppBarCloseButton(Colors.black),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Powiadomienia',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Consumer<Notifications>(
                builder: (context, notificationsData, child) {
                  return Text(
                    notificationsData.unreadNotifications.toString(),
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
              // StreamBuilder(
              //   stream: channel.stream,
              //   builder: (context, snapshot) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 24.0),
              //       child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
