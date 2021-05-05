import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_input_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_posts.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class TopicScreen extends StatefulWidget {
  static const routeName = '/topic';

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final _postToReplySubject = PublishSubject<PostModel>();

  @override
  void dispose() {
    _postToReplySubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topic = ModalRoute.of(context).settings.arguments as TopicModel;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Temat',
        leading: const AppBarBackButton(Colors.black),
        actions: [
          _buildToggleButton(topic),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TopicScreenTopicInfo(topic),
                        TopicScreenPosts(topic, _postToReplySubject),
                      ],
                    ),
                  ),
                ),
                TopicScreenInputBar(topic.id, _postToReplySubject),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildToggleButton(TopicModel topic) {
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
                  isObservedTopic
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  size: 22,
                  color: Colors.black),
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
