import 'package:BSApp/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PostItemBottomBar extends StatelessWidget {
  final PostModel post;
  final PublishSubject<PostModel> postToReplySubject;

  const PostItemBottomBar(this.post, this.postToReplySubject);

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
              postToReplySubject.add(post);
            },
          ),
        ],
      ),
    );
  }
}
