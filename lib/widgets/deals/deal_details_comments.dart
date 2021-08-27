import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/comments/comment_with_replies_item.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsComments extends StatelessWidget {
  final String dealId;

  const DealDetailsComments(this.dealId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Comments>(context, listen: false).fetchCommentsForDeal(dealId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            return Consumer<Comments>(
              builder: (context, commentsData, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _commentsHeader(),
                    _commentsSection(commentsData)
                  ],
                );
              },
            );
          }
        }
      },
    );
  }

  Widget _commentsHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
      child: const Text(
        'KOMENTARZE',
        style: TextStyle(color: MyColorsProvider.DEEP_BLUE, fontSize: 12),
      ),
    );
  }

  Widget _commentsSection(final Comments commentsData) {
    if (commentsData.parentComments.isEmpty) {
      return _noOneAddedACommentSplash();
    } else {
      return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: commentsData.parentComments.length + 1,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container();
          } else {
            final CommentModel parentComment = commentsData.parentComments[index - 1];
            final List<CommentModel> subComments = commentsData.getSubCommentsOf(parentComment.id);
            return CommentWithRepliesItem(dealId, parentComment, subComments);
          }
        },
      );
    }
  }

  Widget _noOneAddedACommentSplash() {
    return Container(
      height: 200,
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nikt jeszcze nie dodał komentarza',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
