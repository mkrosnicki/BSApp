import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/posts.dart';
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
      builder: (context, authData, child) => Consumer<Posts>(
        builder: (context, postsData, child) {
          final bool wasLikedByLoggedUser = postsData.wasLikedBy(postId, authData.userId);
          return InkWell(
            onTap: () {
              _likeTePost(context, topicId, postId, wasLikedByLoggedUser, authData.isAuthenticated);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              alignment: Alignment.centerRight,
              child: Icon(
                CupertinoIcons.heart_fill,
                size: 18,
                color:
                wasLikedByLoggedUser
                    ? MyColorsProvider.RED_SHADY
                    : MyColorsProvider.LIGHT_GRAY,
              ),
            ),
          );
        },
      ),
    );
  }

  _likeTePost(
      BuildContext context,
      String topicId,
      String postId,
      bool wasLikedByLoggedUser,
      bool isAuthenticated) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      final bool isPositiveVote = !wasLikedByLoggedUser;
      Provider.of<Posts>(context, listen: false)
          .likeThePost(topicId, postId, isPositiveVote);
    }
  }

}
