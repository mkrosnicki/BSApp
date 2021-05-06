import 'package:flutter/material.dart';

class TopicScreenTopicTitle extends StatelessWidget {

  final String title;

  const TopicScreenTopicTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle1
            .copyWith(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}
