import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/widgets/comments/comment_item_bottom_section.dart';
import 'package:BSApp/widgets/comments/comment_item_top_section.dart';
import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final String dealId;

  const CommentItem(this.comment, this.dealId);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: comment.isParent()
          ? const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 4.0)
          : const EdgeInsets.only(left: 34.0, right: 8.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (comment.isChild()) Divider(),
          CommentItemTopSection(comment, dealId),
          CommentItemBottomSection(comment),
        ],
      ),
    );
  }
}
