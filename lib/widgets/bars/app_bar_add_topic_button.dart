import 'package:BSApp/screens/forum/new_topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarAddTopicButton extends StatelessWidget {

  final Color color;
  final String categoryId;

  const AppBarAddTopicButton(this.color, this.categoryId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(NewTopicScreen.routeName, arguments: categoryId),
      child: TextButton(
        onPressed: () {},
        child: Icon(CupertinoIcons.plus, color: color,),
      ),
    );
  }
}
