import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/providers/post_reply_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostItemBottomBar extends StatelessWidget {
  final PostModel post;

  const PostItemBottomBar(this.post);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text(
              'ODPOWIEDZ',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 11, color: Colors.black38),
            ),
            onPressed: () {
              Provider.of<PostReplyState>(context, listen: false).startPostReply(post.id);
            },
          ),
        ],
      ),
    );
  }
}
