import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostItemHeartButton extends StatelessWidget {

  final String topicId;
  final String postId;

  PostItemHeartButton(this.topicId, this.postId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Comments>(
        builder: (context, commentsData, child) {
          // final bool wasVotedByLoggedUser = commentsData.wasVotedPositivelyBy(commentId, authData.userId);
          final bool wasVotedByLoggedUser = false;
          return InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.centerRight,
              child: Icon(
                CupertinoIcons.heart_fill,
                size: 16,
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
