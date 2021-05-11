import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/screens/forum/new_topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarAddTopicButton extends StatelessWidget {

  final TopicCategoryModel topicCategory;

  const AppBarAddTopicButton(this.topicCategory);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(NewTopicScreen.routeName, arguments: topicCategory),
      child: const Icon(CupertinoIcons.plus, color: Colors.black,),
    );
  }
}
