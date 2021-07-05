import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/screens/forum/new_topic_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarAddTopicButton extends StatelessWidget {

  final TopicCategoryModel topicCategory;

  const AppBarAddTopicButton(this.topicCategory);

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        return TextButton(
          onPressed: () {
            if (currentUser.isAuthenticated) {
              Navigator.of(context).pushNamed(NewTopicScreen.routeName, arguments: topicCategory);
            } else {
              AuthScreenProvider.showLoginScreen(context);
            }
          },
          child: const Icon(CupertinoIcons.plus, color: Colors.white,),
        );
      },
    );
  }
}