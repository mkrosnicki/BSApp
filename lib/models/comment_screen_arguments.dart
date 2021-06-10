import 'package:BSApp/models/notification_type.dart';

import 'activity_type.dart';

class CommentScreenArguments {
  final String dealId;
  final String dealTitle;
  final String commentToScrollId;
  final String parentCommentId;
  final NotificationType notificationType;
  final ActivityType activityType;

  CommentScreenArguments(
    this.dealId,
    this.dealTitle,
    this.commentToScrollId,
    this.parentCommentId,
    this.notificationType,
    this.activityType,
  );
}
