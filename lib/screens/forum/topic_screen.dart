import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/forum/topic_screen_input_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_posts.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text(
          'Temat',
          style: MyStylingProvider.TEXT_BLACK,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(Colors.black),
        bottom: const AppBarBottomBorder(),
        actions: [
          TextButton(
            onPressed: () {}, // todo dodaj do obserwowanych
            child: Icon(
              CupertinoIcons.heart,
              color: Colors.black87,
            ),
          ),
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
}
