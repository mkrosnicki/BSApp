import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class TopicItemTopBar extends StatelessWidget {
  final TopicModel topic;

  TopicItemTopBar(this.topic);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          child: UserAvatar(
            username: topic.adderInfo.username,
            radius: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleLine(context),
              _buildUserInfoLine(context),
            ],
          ),
        ),
      ],
    );
  }

  _buildTitleLine(BuildContext context) {
    return Text(
      topic.title,
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
    );
  }

  _buildUserInfoLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Text(
            '${topic.adderInfo.username}',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 11, color: Colors.blue, fontWeight: FontWeight.w600),
          ),
          Text(
            ' • ',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 12, color: Colors.black38),
          ),
          Text(
            '${DateUtil.timeAgoString(topic.addedAt)}',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 12, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
