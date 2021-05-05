import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClearNotificationsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _clearNotifications,
      child: const Text(
        'Wyczyść',
        style: const TextStyle(color: MyColorsProvider.BLUE),
      ),
    );
  }

  _clearNotifications() {}
}
