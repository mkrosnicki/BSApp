import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/widgets/forum/post_item_user_info.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_bottom_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_content.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicScreenTopicInfo extends StatelessWidget {
  final TopicModel topic;

  const TopicScreenTopicInfo(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostItemUserInfo(topic.adderInfo, topic.addedAt),
          TopicScreenTopicTitle(topic.title),
          TopicScreenTopicContent(topic.content),
          // TopicScreenTopicBottomBar(topic.id),
        ],
      ),
    );
  }
}
