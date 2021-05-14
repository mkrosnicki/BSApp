import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/deal_screen_arguments.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/comments/comment_item.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CommentScreen extends StatelessWidget {
  static const routeName = '/comment-screen';

  final PublishSubject<CommentModel> _commentToReplySubject = PublishSubject<CommentModel>();

  @override
  Widget build(BuildContext context) {
    final CommentScreenArguments commentScreenArguments =
    ModalRoute
        .of(context)
        .settings
        .arguments as CommentScreenArguments;
    final String dealId = commentScreenArguments.dealId;
    final String commentToScrollId = commentScreenArguments.commentToScrollId;
    final CommentModel comment = commentScreenArguments.comment;

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Odpowiedź na komentarz',
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(),
        padding: const EdgeInsets.all(0),
        child: FutureBuilder(
          future: Provider.of<Comments>(context, listen: false).fetchComment(comment.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: Consumer<Comments>(
                        builder: (context, commentsData, child) {
                          final CommentModel aComment = commentsData.findById(comment.id);
                          return ScrollablePositionedList.builder(
                            itemCount: aComment.subComments.length + 1,
                            initialScrollIndex: _determineInitialIndex(commentToScrollId, aComment.subComments),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return CommentItem(comment, dealId, _commentToReplySubject);
                              } else {
                                return CommentItem(
                                    aComment.subComments[index - 1], dealId, _commentToReplySubject);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    DealDetailsNewComment(dealId, _commentToReplySubject),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }

  int _determineInitialIndex(String postToScrollId, List<CommentModel> comments) {
    final int foundIndex = comments.indexWhere((comment) => comment.id == postToScrollId);
    return foundIndex != -1 ? foundIndex + 1 : 0;
  }

  void _navigateToDeal(BuildContext context, String dealId) {
    final dealsProvider = Provider.of<Deals>(context, listen: false);
    dealsProvider.fetchDeal(dealId).then((_) {
      final DealModel deal = dealsProvider.findById(dealId);
      Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
    });
  }
}
