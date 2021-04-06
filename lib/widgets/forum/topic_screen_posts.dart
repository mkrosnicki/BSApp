import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/posts.dart';
import 'package:BSApp/widgets/forum/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicScreenPosts extends StatelessWidget {

  final TopicModel topic;

  TopicScreenPosts(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      child: Column(
        children: [
          FutureBuilder(
            future: Provider.of<Posts>(context, listen: false).fetchPostsForTopic(topic.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.error != null) {
                  return Center(
                    child: Text('An error occurred!'),
                  );
                } else {
                  return Consumer<Posts>(
                    builder: (context, postsData, child) => Column(
                      children: postsData.allTopicPosts
                          .map((post) => PostItem(post))
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
