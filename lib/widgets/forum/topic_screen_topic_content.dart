import 'package:flutter/material.dart';

class TopicScreenTopicContent extends StatelessWidget {
  final String content;

  TopicScreenTopicContent(this.content);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(fontSize: 12, color: Colors.black87),
    );
  }
}
