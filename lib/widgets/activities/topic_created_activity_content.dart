import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicCreatedActivityContent extends StatelessWidget {

  final String username;
  final TopicModel topic;

  TopicCreatedActivityContent(this.username, this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '$username rozpoczął nowy temat',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              topic.title,
              style:
              TextStyle(
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
