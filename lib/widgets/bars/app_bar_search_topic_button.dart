import 'package:BSApp/screens/forum/topic_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarSearchTopicButton extends StatelessWidget {
  const AppBarSearchTopicButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(
        TopicSearchScreen.routeName,
      ),
      child: const Icon(
        CupertinoIcons.search,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}
