import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/widgets/forum/post_item_user_info.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostItemUserInfo(post),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            child: Text(
              post.content + post.content + post.content + post.content + post.content + post.content + post.content + post.content + post.content,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 12, color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'ODPOWIEDZ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 11, color: Colors.black38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
