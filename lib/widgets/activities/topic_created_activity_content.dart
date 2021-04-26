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
          RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            text: TextSpan(
              text:
              '${username} rozpoczął na forum nowy temat: ',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 12,
                color: Colors.black,
                height: 1.3,
              ),
              children: [
                TextSpan(
                  text: '${topic.title}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              topic.content,
              style: TextStyle(
                  fontSize: 11, color: Colors.black54, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
