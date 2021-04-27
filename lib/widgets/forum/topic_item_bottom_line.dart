import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class TopicItemBottomLine extends StatelessWidget {
  final TopicModel topic;

  TopicItemBottomLine(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${topic.numberOfPosts} postów',
            style: const TextStyle(
                fontSize: 11, color: Colors.black54, height: 1.1),
          ),
          Text(
            '${DateUtil.timeAgoString(topic.addedAt)}',
            style: const TextStyle(
                fontSize: 11, color: Colors.black54, height: 1.1),
          ),
        ],
      ),
    );
  }
}
