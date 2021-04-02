import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/forum/topic_item_user_info.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final TopicModel topic;

  const TopicItem(this.topic);

  @override
  Widget build(BuildContext context) {
    print(topic);
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
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
              child: Text(
                topic.title,
                style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 16),
              ),
            ),
            Text(
              topic.content,
              style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
      onTap: () => _navigateTo(context),
    );
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName, arguments: topic);
  }
}
