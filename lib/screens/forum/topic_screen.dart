import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/forum/topic_screen_input_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_posts.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreen extends StatefulWidget {
  static const routeName = '/topic';

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  bool isInReplyState;

  @override
  void initState() {
    isInReplyState = true;
  }

  @override
  Widget build(BuildContext context) {
    final topicId = ModalRoute.of(context).settings.arguments as String;
    final topic = Provider.of<Topics>(context, listen: false).findById(topicId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wątek',
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => {
          setState(() {
            FocusScope.of(context).unfocus();
            isInReplyState = false;
          })
        },
        child: Container(
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
                          TopicScreenPosts(topic),
                        ],
                      ),
                    ),
                  ),
                  TopicScreenInputBar(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
