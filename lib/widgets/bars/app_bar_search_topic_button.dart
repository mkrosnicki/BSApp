import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/screens/forum/new_topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarSearchTopicButton extends StatelessWidget {

  const AppBarSearchTopicButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(NewTopicScreen.routeName,),
      child: const Icon(CupertinoIcons.search, color: Colors.black,),
    );
  }
}
