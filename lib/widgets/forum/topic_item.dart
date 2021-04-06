import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:BSApp/widgets/forum/topic_item_user_info.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final TopicModel topic;

  const TopicItem(this.topic);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.topLeft,
        color: Colors.white,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopicItemUserInfo(topic),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: Text(
                topic.title,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontSize: 15),
              ),
            ),
            Text(
              shortenTo(topic.content + topic.content + topic.content + topic.content + topic.content, 100),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 12, color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Text(
                    // '${_dateFormat.format(comment.addedAt)}',
                    '${DateUtil.timeAgoString(topic.addedAt)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 11, color: Colors.black38),
                  ),
                  Text(
                    ' • ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 11, color: Colors.black38),
                  ),
                  Text(
                    '10 odpowiedzi',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 11, color: Colors.black38),
                  ),
                  Text(
                    ' • ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 11, color: Colors.black38),
                  ),
                  Text(
                    '10 odpowiedzi',
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
      ),
      onTap: () => _navigateTo(context),
    );
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName, arguments: topic.id);
  }

  String shortenTo(String input, int length) {
    if (input.length <= length) {
      return input;
    } else {
      return input.substring(0, length) + "...";
    }
  }
}
