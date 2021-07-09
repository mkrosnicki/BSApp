import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartSearchTopicButton extends StatelessWidget {

  Function onClick;

  StartSearchTopicButton(this.onClick);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(),
      child: const Text(
        'Szukaj',
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
    );
  }
}
