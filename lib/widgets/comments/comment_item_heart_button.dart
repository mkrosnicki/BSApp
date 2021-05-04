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

  CommentItemHeartButton(this.dealId, this.commentId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Comments>(
        builder: (context, commentsData, child) {
          final bool wasVotedByLoggedUser = commentsData.wasVotedPositivelyBy(commentId, authData.userId);
          return InkWell(
            onTap: () => _voteForComment(
                context, dealId, commentId, wasVotedByLoggedUser, authData.isAuthenticated),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerRight,
              child: Icon(
                CupertinoIcons.heart_fill,
                size: 14,
                color:
                wasVotedByLoggedUser
                    ? MyColorsProvider.RED_SHADY
                    : MyColorsProvider.LIGHT_GRAY,
              ),
            ),
          );
        },
      ),
    );
  }

  _voteForComment(
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
