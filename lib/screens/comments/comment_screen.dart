import 'package:BSApp/models/activity_type.dart';
import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/comment_screen_arguments.dart';
import 'package:BSApp/models/deal_model.dart';
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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CommentScreen extends StatefulWidget {
  static const routeName = '/comment-screen';

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  CommentModel _comment;
  List<CommentModel> _subComments;

  @override
  Widget build(BuildContext context) {
    final CommentScreenArguments arguments = ModalRoute.of(context).settings.arguments as CommentScreenArguments;
    final String dealId = arguments.dealId;
    final String commentToScrollId = arguments.commentToScrollId;
    final String parentCommentId = arguments.parentCommentId;

    return Scaffold(
      appBar: BaseAppBar(
        title: _screenTitle(arguments),
        leading: const AppBarBackButton(Colors.white),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(),
        padding: const EdgeInsets.all(0),
        child: FutureBuilder(
          future: Provider.of<Comments>(context, listen: false).fetchCommentWithSubComments(parentCommentId),
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
                    _buildDealNavigationPanel(context, arguments),
                    Expanded(
                      child: Consumer<Comments>(
                        builder: (context, commentsData, child) {
                          _comment = commentsData.findById(parentCommentId);
                          _subComments = commentsData.getSubCommentsOf(parentCommentId);
                          return ScrollablePositionedList.builder(
                            itemCount: _subComments.length + 1,
                            initialScrollIndex: _determineInitialIndex(commentToScrollId, _comment, _subComments),
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return CommentItem(_comment, dealId);
                              } else {
                                return CommentItem(_subComments[index - 1], dealId);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    DealDetailsNewComment(dealId),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }

  int _determineInitialIndex(String commentToScrollId, CommentModel comment, List<CommentModel> subComments) {
    if (comment.id == commentToScrollId) {
      return 0;
    } else {
      final int foundIndex = subComments.indexWhere((comment) => comment.id == commentToScrollId);
      return foundIndex != -1 ? foundIndex + 1 : 0;
    }
  }

  Widget _buildDealNavigationPanel(BuildContext context, CommentScreenArguments screenArguments) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.only(top: 12.0, left: 8.0, bottom: 12.0),
      child: Row(
        children: [
          const NotificationItemIcon(NotificationType.YOUR_DEAL_COMMENTED),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _notificationString(screenArguments),
                  style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
                ),
                Text(
                  screenArguments.dealTitle,
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
              child: _buildNavigationButton(context, screenArguments.dealId),
            ),
          ),
        ],
      ),
    );
  }

  String _notificationString(CommentScreenArguments screenArguments) {
    if (screenArguments.activityType != null) {
      return _notificationStringByActivityType(screenArguments.activityType);
    } else {
      return _notificationStringByNotificationType(screenArguments.notificationType);
    }
  }

  String _notificationStringByActivityType(ActivityType activityType) {
    switch (activityType) {
      case ActivityType.COMMENT_ADDED:
        return 'Komentarz do okazji';
      case ActivityType.COMMENT_REPLIED:
        return 'Odpowiedź na komentarz';
      default:
        return '';
    }
  }

  String _notificationStringByNotificationType(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.YOUR_DEAL_COMMENTED:
        return 'Komentarz do Twojej okazji';
      case NotificationType.YOUR_COMMENT_RATED:
      case NotificationType.YOUR_COMMENT_REPLIED:
      case NotificationType.YOUR_COMMENT_RATED:
        return 'Twój komentarz do okazji';
      default:
        return '';
    }
  }

  String _screenTitle(CommentScreenArguments screenArguments) {
    if (screenArguments.activityType != null) {
      return _screenTitleByActivityType(screenArguments.activityType);
    } else {
      return _screenTitleByNotificationType(screenArguments.notificationType);
    }
  }

  String _screenTitleByNotificationType(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.YOUR_DEAL_COMMENTED:
      case NotificationType.YOUR_COMMENT_REPLIED:
        return 'Nowy komentarz';
      case NotificationType.YOUR_COMMENT_RATED:
        return 'Polubiony komentarz';
      default:
        return '';
    }
  }

  String _screenTitleByActivityType(ActivityType activityType) {
    switch (activityType) {
      case ActivityType.COMMENT_ADDED:
      case ActivityType.COMMENT_REPLIED:
        return 'Nowy komentarz';
      default:
        return '';
    }
  }

  Widget _buildNavigationButton(BuildContext context, String dealId) {
    return GestureDetector(
      onTap: () => _navigateToDeal(context, dealId),
      child: Container(
        padding: const EdgeInsets.only(left: 2.0, top: 2.0, bottom: 2.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            Text(
              'Zobacz okazję',
              style: TextStyle(color: MyColorsProvider.DEEP_BLUE, fontSize: 12),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.0),
              child: Icon(CupertinoIcons.forward, size: 18, color: MyColorsProvider.DEEP_BLUE),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToDeal(BuildContext context, String dealId) {
    final dealsProvider = Provider.of<Deals>(context, listen: false);
    dealsProvider.fetchDeal(dealId).then((_) {
      final DealModel deal = dealsProvider.findById(dealId);
      Navigator.of(context).pushReplacementNamed(DealDetailsScreen.routeName, arguments: deal);
    });
  }
}
