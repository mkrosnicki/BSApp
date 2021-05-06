import 'package:flutter/material.dart';

class TopicScreenTopicBottomBar extends StatelessWidget {
  final String topicId;

  const TopicScreenTopicBottomBar(this.topicId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'ODPOWIEDZ',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 11, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
