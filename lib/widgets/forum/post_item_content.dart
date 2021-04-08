import 'package:BSApp/models/post_model.dart';
import 'package:flutter/material.dart';

class PostItemContent extends StatelessWidget {
  final PostModel post;

  const PostItemContent(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
      child: Text(
        post.content,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(fontSize: 12, color: Colors.black87),
      ),
    );
  }
}
