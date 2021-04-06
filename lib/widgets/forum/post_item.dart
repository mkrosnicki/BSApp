import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/widgets/forum/post_item_bottom_bar.dart';
import 'package:BSApp/widgets/forum/post_item_content.dart';
import 'package:BSApp/widgets/forum/post_item_quote.dart';
import 'package:BSApp/widgets/forum/post_item_user_info.dart';
import 'package:flutter/cupertino.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostItemUserInfo(post.adderInfo, post.addedAt),
          if (post.quote != null) PostItemQuote(post),
          PostItemContent(post),
          PostItemBottomBar(post),
        ],
      ),
    );
  }
}
