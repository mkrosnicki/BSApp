import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClearNotificationsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _clearNotifications(context),
      child: const Text(
        'Wyczyść',
        style: TextStyle(color: MyColorsProvider.BLUE),
      ),
    );
  }

  void _clearNotifications(BuildContext context) {
    Provider.of<Notifications>(context, listen: false).deleteMyNotifications();
  }
}
