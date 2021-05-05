import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/widgets/forum/post_item_bottom_bar.dart';
import 'package:BSApp/widgets/forum/post_item_content.dart';
import 'package:BSApp/widgets/forum/post_item_quote.dart';
import 'package:BSApp/widgets/forum/topic_sceen_user_info.dart';
import 'package:BSApp/widgets/forum/post_item_user_info_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PostItem extends StatelessWidget {
  final PostModel post;
  final PublishSubject<PostModel> postToReplySubject;

  PostItem(this.post, this.postToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      color: Colors.white,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostItemUserInfoNew(post.adderInfo, post.addedAt),
          if (post.quote != null) PostItemQuote(post),
          PostItemContent(post),
          PostItemBottomBar(post, postToReplySubject),
        ],
      ),
    );
  }
}
