import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/post_item.dart';
import 'package:BSApp/widgets/forum/topic_screen_topic_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TopicScreenPosts extends StatelessWidget {
  final TopicModel topic;
  final String postToScrollId;

  const TopicScreenPosts(this.topic, this.postToScrollId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Posts>(
      builder: (context, postsData, child) {
        return ScrollablePositionedList.builder(
          itemCount: postsData.posts.length + 1,
          initialScrollIndex: _determineInitialIndex(postToScrollId, postsData.posts),
          itemBuilder: (context, index) {
            if (index == 0) {
              return TopicScreenTopicInfo(topic);
            } else {
              return PostItem(postsData.posts[index - 1]);
            }
          },
        );
      },
    );
  }

  int _determineInitialIndex(String postToScrollId, List<PostModel> posts) {
    final int foundIndex = posts.indexWhere((post) => post.id == postToScrollId);
    return foundIndex != -1 ? foundIndex + 1 : 0;
  }
}
