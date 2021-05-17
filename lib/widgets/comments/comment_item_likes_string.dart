import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/util/conjugation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemLikesString extends StatelessWidget {
  final String commentId;

  const CommentItemLikesString(this.commentId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Comments>(
      builder: (context, commentsData, child) {
        final CommentModel aComment = commentsData.findById(commentId);
        return Text(
          '${aComment.numberOfPositiveVotes} ${ConjugationHelper.likesConjugation(aComment.numberOfPositiveVotes)}',
          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 11, color: Colors.grey),
        );
      },
    );
  }
}
