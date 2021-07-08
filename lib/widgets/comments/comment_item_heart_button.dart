import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemHeartButton extends StatelessWidget {

  final String dealId;
  final String commentId;

  const CommentItemHeartButton(this.dealId, this.commentId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Comments>(
        builder: (context, commentsData, child) {
          final CommentModel comment = commentsData.findById(commentId);
          final bool wasVotedByLoggedUser = comment.wasLikedBy(authData.userId);
          return Container(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () => _voteForComment(
                  context, dealId, commentId, wasVotedByLoggedUser, authData.isAuthenticated),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Icon(
                  CupertinoIcons.heart_fill,
                  size: 18,
                  color:
                  wasVotedByLoggedUser
                      ? MyColorsProvider.RED_SHADY
                      : MyColorsProvider.LIGHT_GRAY,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _voteForComment(
      BuildContext context,
      String dealId,
      String commentId,
      bool wasVotedByLoggedUser,
      bool isAuthenticated) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      final bool isPositiveVote = !wasVotedByLoggedUser;
      Provider.of<Comments>(context, listen: false)
          .voteForComment(dealId, commentId, isPositiveVote);
    }
  }
}
