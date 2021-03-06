import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/topic_screen_admin_actions_button.dart';
import 'package:BSApp/widgets/forum/topic_screen_heart_button.dart';
import 'package:BSApp/widgets/forum/topic_screen_input_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreen extends StatefulWidget {
  static const routeName = '/topic';

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {

  @override
  Widget build(BuildContext context) {
    final TopicScreenArguments topicScreenArguments = ModalRoute.of(context).settings.arguments as TopicScreenArguments;
    final TopicModel topic = topicScreenArguments.topic;
    return Scaffold(
      appBar: BaseAppBar(
        title: topic.title,
        leading: const AppBarBackButton(Colors.white),
        actions: [
          Consumer<CurrentUser>(
            builder: (context, currentUser, child) {
              return currentUser.isAdmin ? TopicScreenAdminActionsButton(topic) : Container();
            },
          ),
          TopicScreenHeartButton(topic),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(),
        padding: const EdgeInsets.all(0),
        child: FutureBuilder(
          future: Provider.of<Posts>(context, listen: false).fetchPostsForTopic(topic.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: TopicScreenPosts(topic, topicScreenArguments.postToScrollId),
                    ),
                    TopicScreenInputBar(topic.id),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
