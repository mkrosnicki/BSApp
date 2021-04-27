import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/widgets/forum/topic_item_top_bar.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final TopicModel topic;

  const TopicItem(this.topic);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: TopicItemTopBar(topic),
        ),
      ),
      onTap: () => _navigateTo(context),
    );
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName, arguments: topic.id);
  }

  String shortenTo(String input, int length) {
    if (input.length <= length) {
      return input;
    } else {
      return input.substring(0, length) + "...";
    }
  }
}
