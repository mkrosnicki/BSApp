import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../comments/comment_with_replies_item.dart';

class DealDetailsComments extends StatelessWidget {
  final DealModel deal;
  final PublishSubject<CommentModel> commentToReplySubject;

  const DealDetailsComments(this.deal, this.commentToReplySubject);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 12.0, bottom: 8.0, left: 12.0, right: 6.0),
          // margin: const EdgeInsets.only(top: 8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Komentarze',
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          // margin: const EdgeInsets.only(top: 5.0),
          // padding: const EdgeInsets.only(top: 5.0),
          child: FutureBuilder(
            future: Provider.of<Comments>(context, listen: false).fetchCommentsForDeal(deal.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 200,
                  color: Colors.white,
                  child: const Center(child: LoadingIndicator()),
                );
              } else {
                if (snapshot.error != null) {
                  return const Center(
                    child: ServerErrorSplash(),
                  );
                } else {
                  return Consumer<Comments>(
                    builder: (context, commentsData, child) {
                      if (commentsData.parentComments.isEmpty) {
                        return _noOneAddedACommentSplash();
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: commentsData.parentComments.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CommentWithRepliesItem(
                                deal.id, commentsData.parentComments[index], commentToReplySubject);
                          },
                        );
                      }
                    },
                  );
                }
              }
            },
          ),
        )
      ],
    );
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
