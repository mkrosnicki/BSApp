import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/widgets/forum/topic_item_bottom_line.dart';
import 'package:BSApp/widgets/forum/topic_item_heart_button.dart';
import 'package:BSApp/widgets/forum/topic_item_title_lines.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicItemTopicInfo extends StatelessWidget {
  final TopicModel topic;

  const TopicItemTopicInfo(this.topic);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopicItemTitleLines(topic),
                Wrap(
                  children: [
                    if (topic.pinned) const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(CupertinoIcons.lock_fill, size: 17,),
                    ),
                    TopicItemHeartButton(topic),
                  ],
                ),
              ],
            ),
            TopicItemBottomLine(topic),
          ],
        ),
      ),
    );
  }
}
