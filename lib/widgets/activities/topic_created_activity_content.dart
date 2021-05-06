import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicCreatedActivityContent extends StatelessWidget {

  final String username;
  final TopicModel topic;

  const TopicCreatedActivityContent(this.username, this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$username założył(a) nowy temat',
            style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              topic.title,
              style:
              const TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
