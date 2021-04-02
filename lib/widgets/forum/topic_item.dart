import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final TopicModel topic;

  const TopicItem(this.topic);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(topic.title, style: TextStyle(fontSize: 14),),
        trailing: Icon(Icons.chevron_right),
        focusColor: Colors.grey,
      ),
      shape: Border(bottom: const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5)),
      onPressed: () => _navigateTo(context),
    );
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName, arguments: topic);
  }
}
