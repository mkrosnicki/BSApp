import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicItemTitleLines extends StatelessWidget {
  final TopicModel topic;

  TopicItemTitleLines(this.topic);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleLine(context),
        _buildUserInfoLine(context),
      ],
    );
  }

  _buildTitleLine(BuildContext context) {
    return Text(
      topic.title,
      style: Theme.of(context).textTheme.subtitle1.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  _buildUserInfoLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        children: [
          Text(
            '${topic.adderInfo.username}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
