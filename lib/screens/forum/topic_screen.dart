import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/app_bar_bottom_border.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
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
    isInReplyState = false;
  }

  @override
  Widget build(BuildContext context) {
    final topicId = ModalRoute.of(context).settings.arguments as String;
    final topic = Provider.of<Topics>(context, listen: false).findById(topicId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forum',
          style: MyStylingProvider.TEXT_BLACK,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: const AppBarBottomBorder(),
        leading: const AppBarBackButton(Colors.black),
        actions: [
          const AppBarCloseButton(Colors.black),
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
                        ],
                      ),
                    ),
                  ),
                  if (isInReplyState)
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                      color: Colors.white,
                      child: Center(
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: 'Napisz komentarz',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          onChanged: (value) {
                            // setState(() {
                            //   _commentText = value;
                            // });
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: isInReplyState
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  isInReplyState = true;
                });
              },
              child: const Icon(CupertinoIcons.reply),
              backgroundColor: Colors.deepOrange,
            ),
      // bottomNavigationBar: MyNavigationBar(1),
    );
  }
}
