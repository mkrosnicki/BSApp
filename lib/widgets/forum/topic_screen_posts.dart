import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class TopicScreenPosts extends StatelessWidget {

  final TopicModel topic;
  final PublishSubject<PostModel> postToReplySubject;

  const TopicScreenPosts(this.topic, this.postToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          FutureBuilder(
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
                  return Consumer<Posts>(
                    builder: (context, postsData, child) => Column(
                      children: postsData.allTopicPosts
                          .map((post) => PostItem(post, postToReplySubject))
                          .toList(),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
