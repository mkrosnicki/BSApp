import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/widgets/forum/topic_item_user_info.dart';
import 'package:flutter/material.dart';

class TopicScreenTopicInfo extends StatelessWidget {
  final TopicModel topic;

  const TopicScreenTopicInfo(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopicItemUserInfo(topic),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0),
            child: Text(
              topic.title,
              style:
                  Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 15),
            ),
          ),
          Text(
            topic.content,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(fontSize: 12, color: Colors.black87),
          ),
          Padding(
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
          ),
        ],
      ),
    );
  }
}
