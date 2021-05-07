import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicItemHeartButton extends StatelessWidget {
  final TopicModel topic;

  const TopicItemHeartButton(this.topic);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        final bool isObservedTopic = currentUser.observesTopic(topic);
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _toggleFavourites(
              context, topic, isObservedTopic, currentUser.isAuthenticated),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Icon(CupertinoIcons.heart_fill,
                size: 20,
                color: isObservedTopic
                    ? MyColorsProvider.RED_SHADY
                    : MyColorsProvider.LIGHT_GRAY),
          ),
        );
      },
    );
  }

  void _toggleFavourites(BuildContext context, TopicModel topic,
      bool isFavourite, bool isUserLoggedIn) {
    final currentUserProvider =
        Provider.of<CurrentUser>(context, listen: false);
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else if (isFavourite) {
      currentUserProvider.removeFromObservedTopics(topic.id);
    } else {
      currentUserProvider.addToObservedTopics(topic.id);
    }
  }
}
