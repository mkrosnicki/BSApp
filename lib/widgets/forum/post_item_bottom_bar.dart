import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PostItemBottomBar extends StatelessWidget {
  final PostModel post;
  final PublishSubject<PostModel> postToReplySubject;

  const PostItemBottomBar(this.post, this.postToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(top: 0.0),
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'ODPOWIEDZ',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(fontSize: 11, color: MyColorsProvider.BLUE),
        ),
        onPressed: () {
          postToReplySubject.add(post);
        },
      ),
    );
  }
}
