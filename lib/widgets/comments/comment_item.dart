import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/comments/comment_item_bottom_section.dart';
import 'package:BSApp/widgets/comments/comment_item_content.dart';
import 'package:BSApp/widgets/comments/comment_item_top_section.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final String dealId;

  const CommentItem(this.comment, this.dealId);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: comment.isParent() ? MyStylingProvider.ITEMS_MARGIN : MyStylingProvider.ITEMS_MARGIN.copyWith(left: 26.0),
      decoration: MyStylingProvider.ITEMS_BORDER.copyWith(color: Colors.white),
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentItemTopSection(comment, dealId),
          CommentItemContent(comment),
          CommentItemBottomSection(comment),
        ],
      ),
    );
  }
}
