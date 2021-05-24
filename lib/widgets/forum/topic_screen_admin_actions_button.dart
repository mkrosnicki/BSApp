import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreenAdminActionsButton extends StatelessWidget {
  final TopicModel topic;

  const TopicScreenAdminActionsButton(this.topic);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        final bool isObservedTopic = currentUser.observesTopic(topic);
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _openAdminActions(context, topic, isObservedTopic, currentUser.isAuthenticated),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(CupertinoIcons.ellipsis_vertical, size: 22, color: Colors.black),
          ),
        );
      },
    );
  }

  void _openAdminActions(BuildContext context, TopicModel topic, bool isFavourite, bool isUserLoggedIn) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Akcje admina'),
              ),
              if (!topic.pinned) _buildListTile('Przypnij wątek', CupertinoIcons.lock_fill, () {
                Provider.of<Topics>(context, listen: false).updatetopic(topic.id, true);
                Navigator.of(context).pop();
              }),
              if (topic.pinned) _buildListTile('Odepnij wątek', CupertinoIcons.lock, () {
                Provider.of<Topics>(context, listen: false).updatetopic(topic.id, false);
                Navigator.of(context).pop();
              }),
              _buildListTile('Usuń wątek', CupertinoIcons.clear, () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListTile(String title, IconData icon, Function() function) {
    return ListTile(
      leading: Icon(icon, size: 18,),
      onTap: function,
      title: Text(title, style: TextStyle(fontSize: 13),),
    );
  }
}
