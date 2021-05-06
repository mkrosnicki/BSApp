import 'package:flutter/material.dart';

class TopicScreenTopicContent extends StatelessWidget {
  final String content;

  const TopicScreenTopicContent(this.content);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        content,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(fontSize: 12, color: Colors.black87),
      ),
    );
  }
}
