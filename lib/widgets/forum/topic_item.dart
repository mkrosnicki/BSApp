import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_styling_provider.dart';
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
      child: Container(
        alignment: Alignment.topLeft,
        margin: MyStylingProvider.ITEMS_MARGIN,
        decoration: MyStylingProvider.ITEMS_BORDER,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Row(
          children: [
            TopicItemUserAvatar(topic),
            TopicItemTopicInfo(topic),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName, arguments: TopicScreenArguments(topic));
  }

  String shortenTo(String input, int length) {
    if (input.length <= length) {
      return input;
    } else {
      return "${input.substring(0, length)}...";
    }
  }
}
