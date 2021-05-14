import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/comments/comment_item_bottom_section.dart';
import 'package:BSApp/widgets/comments/comment_item_top_section.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final String dealId;
  final PublishSubject<CommentModel> commentToReplySubject;

  const CommentItem(this.comment, this.dealId, this.commentToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      width: double.infinity,
      padding: comment.isParent()
          ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0)
          : const EdgeInsets.only(left: 20.0, right: 8.0, top: 8.0, bottom: 8.0),
      margin: const EdgeInsets.only(bottom: 4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        color: Colors.white,
        border: Border.all(
          color: MyColorsProvider.GREY_BORDER_COLOR,
          width: 0.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentItemTopSection(comment, dealId),
          CommentItemBottomSection(comment, commentToReplySubject),
        ],
      ),
    );
  }
}
