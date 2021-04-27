import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class TopicItemTopBar extends StatelessWidget {
  final TopicModel topic;

  TopicItemTopBar(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
            child: UserAvatar(
              username: topic.adderInfo.username,
              radius: 20,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleLine(context),
                  _buildUserInfoLine(context),
                  _buildBottomLine(context),
                ],
              ),
            ),
          ),
        ],
      ),
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

  _buildBottomLine(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${topic.numberOfPosts} postów',
            style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.1),
          ),
          Text(
            '${DateUtil.timeAgoString(topic.addedAt)}',
            style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.1),
          ),
        ],
      ),
    );
  }
}
