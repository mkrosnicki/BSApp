import 'package:BSApp/models/topic_model.dart';
import 'package:flutter/material.dart';

class TopicItemTitleLines extends StatelessWidget {
  final TopicModel topic;

  const TopicItemTitleLines(this.topic);

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

  Widget _buildTitleLine(BuildContext context) {
    return Text(
      topic.title,
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
    );
  }

  Widget _buildUserInfoLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        children: [
          Text(
            topic.adderName,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
