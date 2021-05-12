import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/topic_screen_arguments.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/post_item.dart';
import 'package:BSApp/widgets/forum/topic_screen_heart_button.dart';
import 'package:BSApp/widgets/forum/topic_screen_input_bar.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
    final TopicScreenArguments topicScreenArguments = ModalRoute.of(context).settings.arguments as TopicScreenArguments;
    final TopicModel topic = topicScreenArguments.topic;
    return Scaffold(
      appBar: BaseAppBar(
        title: topic.title,
        leading: const AppBarBackButton(Colors.black),
        actions: [
          TopicScreenHeartButton(topic),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(),
        padding: const EdgeInsets.all(0),
        child: FutureBuilder(
          future: Provider.of<Posts>(context, listen: false)
              .fetchPostsForTopic(topic.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return Consumer<Posts>(
                  builder: (context, postsData, child) {
                    final String postToScrollId = topicScreenArguments.postToScrollId;
                    postsData.posts.indexWhere((element) => element.topicId == postToScrollId);
                    return Column(
                      children: [
                        Expanded(
                          child: ScrollablePositionedList.builder(
                            itemCount: postsData.posts.length + 1,
                            initialScrollIndex: _determineInitialIndex(topicScreenArguments, postsData.posts),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return TopicScreenTopicInfo(topic);
                              } else {
                                return PostItem(
                                    postsData.posts[index - 1], _postToReplySubject);
                              }
                            },
                          ),
                        ),
                        TopicScreenInputBar(topic.id, _postToReplySubject),
                      ],
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }

  int _determineInitialIndex(TopicScreenArguments topicScreenArguments, List<PostModel> posts) {
    final String postToScrollId = topicScreenArguments.postToScrollId;
    final int foundIndex = posts.indexWhere((post) => post.id == postToScrollId);
    return foundIndex != -1 ? foundIndex + 1 : 0;
  }
}
