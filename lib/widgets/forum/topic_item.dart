import 'package:BSApp/screens/forum/topic_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final String title;
  final String route;
  final Function function;

  const TopicItem({this.title, this.route, this.function});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(title, style: TextStyle(fontSize: 14),),
        trailing: Icon(Icons.chevron_right),
        focusColor: Colors.grey,
      ),
      shape: Border(bottom: const BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5)),
      onPressed: () {
        _preformAction(context);
      },
    );
  }

  void _preformAction(BuildContext context) async {
    var shouldNavigate = true;
    if (function != null) {
      shouldNavigate = await function();
    }
    if (shouldNavigate) {
      _navigateTo(context);
    }
  }

  _navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(TopicScreen.routeName);
  }
}
