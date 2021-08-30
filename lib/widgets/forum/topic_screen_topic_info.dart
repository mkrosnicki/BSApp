import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_content.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_title.dart';
import 'package:BSApp/widgets/forum/topic_screen_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicScreenTopicInfo extends StatelessWidget {
  final TopicModel topic;

  const TopicScreenTopicInfo(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      margin: MyStylingProvider.ITEMS_MARGIN,
      decoration: MyStylingProvider.ITEMS_BORDER.copyWith(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopicScreenUserInfo(topic),
          TopicScreenTopicTitle(topic.title),
          TopicScreenTopicContent(topic.content),
          // TopicScreenTopicBottomBar(topic.id),
        ],
      ),
    );
  }
}
