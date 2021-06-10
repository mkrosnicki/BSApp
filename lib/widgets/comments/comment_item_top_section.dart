import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/widgets/comments/comment_item_admin_actions_button.dart';
import 'package:BSApp/widgets/comments/comment_item_content.dart';
import 'package:BSApp/widgets/comments/comment_item_heart_button.dart';
import 'package:BSApp/widgets/comments/comment_item_user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemTopSection extends StatelessWidget {
  final CommentModel comment;
  final String dealId;

  const CommentItemTopSection(this.comment, this.dealId);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Flex(
        crossAxisAlignment: CrossAxisAlignment.start,
        direction: Axis.horizontal,
        children: [
          CommentItemUserAvatar(comment.adderInfo),
          CommentItemContent(comment),
          Column(
            children: [
              Consumer<CurrentUser>(
                builder: (context, currentUser, child) {
                  return currentUser.isAdmin ? CommentItemAdminActionsButton(comment) : Container();
                },
              ),
              CommentItemHeartButton(dealId, comment.id),
            ],
          ),
        ],
      ),
    );
  }
}
