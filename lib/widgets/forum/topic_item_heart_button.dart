import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicItemHeartButton extends StatelessWidget {
  final TopicModel topic;

  TopicItemHeartButton(this.topic);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Topics>(
        builder: (context, topicsData, child) {
          final bool isObservedTopic = topicsData.isObservedTopic(topic);
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => _toggleFavourites(
                context, topic, isObservedTopic, authData.isAuthenticated),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                  CupertinoIcons.heart_fill,
                  size: 20,
                  color: isObservedTopic ? MyColorsProvider.RED_SHADY : MyColorsProvider.LIGHT_GRAY),
            ),
          );
        },
      ),
    );
  }

  _toggleFavourites(BuildContext context, TopicModel topic, bool isFavourite,
      bool isUserLoggedIn) {
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else if (isFavourite) {
      Provider.of<Topics>(context, listen: false)
          .removeFromObservedTopics(topic.id);
    } else {
      Provider.of<Topics>(context, listen: false).addToObservedTopics(topic.id);
    }
  }
}
