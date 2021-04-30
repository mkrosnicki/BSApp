import 'package:flutter/material.dart';

class YourTopicRepliedNotificationContent extends StatelessWidget {
  final String mainReplierUsername;
  final String topicTitle;
  final int numberOfRepliers;

  YourTopicRepliedNotificationContent(
      this.mainReplierUsername, this.topicTitle, this.numberOfRepliers);

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
            numberOfRepliers > 1
                ? '$mainReplierUsername i ${numberOfRepliers - 1} napisali post w Twoim temacie'
                : '$mainReplierUsername napisał post w Twoim temacie',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              topicTitle,
              style: TextStyle(
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
