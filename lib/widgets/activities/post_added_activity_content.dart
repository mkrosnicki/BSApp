import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class PostAddedActivityContent extends StatelessWidget {
  final String username;
  final String topicTitle;

  const PostAddedActivityContent(this.username, this.topicTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$username wypowiedział(a) się w temacie',
            style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              topicTitle,
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
