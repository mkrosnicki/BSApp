import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/widgets/forum/topic_item_topic_info.dart';
import 'package:BSApp/widgets/forum/topic_item_user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final TopicModel topic;

  const TopicItem(this.topic);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateTo(context),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            color: topic.pinned ? Colors.blue.shade50 : Colors.white,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Row(
              children: [
                TopicItemUserAvatar(topic.adderInfo),
                TopicItemTopicInfo(topic),
              ],
            ),
          ),
          if (topic.pinned) const Positioned(
            top: 7.0,
            left: 5.0,
            child: const Icon(
              CupertinoIcons.shield_lefthalf_fill,
              size: 16,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName, arguments: topic);
  }

  String shortenTo(String input, int length) {
    if (input.length <= length) {
      return input;
    } else {
      return "${input.substring(0, length)}...";
    }
  }
}
