import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/deal_screen_arguments.dart';
import 'package:BSApp/models/notification_type.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/comments/comment_item.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:BSApp/widgets/notifications/notification_item_icon.dart';
import 'package:flutter/cupertino.dart';
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
        ModalRoute.of(context).settings.arguments as CommentScreenArguments;
    final String dealId = commentScreenArguments.dealId;
    final String commentToScrollId = commentScreenArguments.commentToScrollId;
    final String parentCommentId = commentScreenArguments.commentId;

    return Scaffold(
      appBar: const BaseAppBar(
        title: 'Komentarze',
        leading: AppBarBackButton(Colors.black),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(),
        padding: const EdgeInsets.all(0),
        child: FutureBuilder(
          future: Provider.of<Comments>(context, listen: false).fetchComment(parentCommentId),
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
                    _buildDealNavigationPanel(),
                    Expanded(
                      child: Consumer<Comments>(
                        builder: (context, commentsData, child) {
                          final CommentModel comment = commentsData.findById(parentCommentId);
                          return ScrollablePositionedList.builder(
                            itemCount: comment.subComments.length + 1,
                            initialScrollIndex: _determineInitialIndex(commentToScrollId, comment),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return CommentItem(comment, dealId, _commentToReplySubject);
                              } else {
                                return CommentItem(comment.subComments[index - 1], dealId, _commentToReplySubject);
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

  int _determineInitialIndex(String commentToScrollId, CommentModel comment) {
    if (comment.id == commentToScrollId) {
      return 0;
    } else {
      final int foundIndex = comment.subComments.indexWhere((comment) => comment.id == commentToScrollId);
      return foundIndex != -1 ? foundIndex + 1 : 0;
    }
  }

  Widget _buildDealNavigationPanel() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.only(top: 12.0, left: 12.0, bottom: 12.0),
      child: Row(
        children: [
          const NotificationItemIcon(NotificationType.YOUR_DEAL_COMMENTED),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Komentarze do okazji',
                  style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
                ),
                Text(
                  'Jakaś tam fajna okazja',
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Container(
                color: Colors.yellow,
                padding: const EdgeInsets.only(left: 2.0, top: 2.0, bottom: 2.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Text(
                      'Zobacz okazję',
                      style: TextStyle(color: MyColorsProvider.DEEP_BLUE, fontSize: 12),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: const Icon(CupertinoIcons.forward, size: 18, color: MyColorsProvider.DEEP_BLUE),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDeal(BuildContext context, String dealId) {
    final dealsProvider = Provider.of<Deals>(context, listen: false);
    dealsProvider.fetchDeal(dealId).then((_) {
      final DealModel deal = dealsProvider.findById(dealId);
      Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
    });
  }
}
