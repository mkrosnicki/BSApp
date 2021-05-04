import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/widgets/comments/comment_item_content.dart';
import 'package:BSApp/widgets/comments/comment_item_heart_button.dart';
import 'package:BSApp/widgets/comments/comment_item_user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentItemTopSection extends StatelessWidget {
  final CommentModel comment;
  final String dealId;

  const CommentItemTopSection(this.comment, this.dealId);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommentItemUserAvatar(comment.adderInfo),
        CommentItemContent(comment),
        CommentItemHeartButton(dealId, comment.id),
      ],
    );
  }
}
