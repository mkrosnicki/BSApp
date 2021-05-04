import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/voting_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentItemVotingButtons extends StatelessWidget {

  final CommentModel comment;
  final String dealId;


  CommentItemVotingButtons(this.comment, this.dealId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Comments>(
        builder: (context, commentsData, child) => Wrap(
          children: [
            VotingButton(
              iconData: CupertinoIcons.hand_thumbsup,
              function: () => _voteForComment(context,
                  dealId, comment.id, true, authData.isAuthenticated),
              trailing: comment.numberOfPositiveVotes.toString(),
              color: MyColorsProvider.GREEN,
              isActive: commentsData.wasVotedPositivelyBy(
                  comment.id, authData.userId),
              showBorder: false,
              fontSize: 12,
            ),
            VotingButton(
              iconData: CupertinoIcons.hand_thumbsdown,
              function: () => _voteForComment(context,
                  dealId, comment.id, false, authData.isAuthenticated),
              trailing: comment.numberOfNegativeVotes.toString(),
              color: Colors.red,
              isActive: commentsData.wasVotedNegativelyBy(
                  comment.id, authData.userId),
              showBorder: false,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  _voteForComment(BuildContext context, String dealId, String commentId,
      bool isPositive, isAuthenticated) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      Provider.of<Comments>(context, listen: false)
          .voteForComment(dealId, commentId, isPositive);
    }
  }
}
