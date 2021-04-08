import 'package:BSApp/screens/forum/new_topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarAddTopicButton extends StatelessWidget {

  final Color color;

  const AppBarAddTopicButton(this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(NewTopicScreen.routeName),
      child: TextButton(
        child: Icon(CupertinoIcons.plus, color: color,),
      ),
    );
  }
}
