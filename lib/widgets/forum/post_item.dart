import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/forum/post_item_bottom_bar.dart';
import 'package:BSApp/widgets/forum/post_item_content.dart';
import 'package:BSApp/widgets/forum/post_item_quote.dart';
import 'package:BSApp/widgets/forum/post_item_user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      margin: MyStylingProvider.ITEMS_MARGIN,
      decoration: MyStylingProvider.ITEMS_BORDER.copyWith(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostItemUserInfo(post),
          if (post.quote != null) PostItemQuote(post),
          PostItemContent(post),
          PostItemBottomBar(post),
        ],
      ),
    );
  }
}
