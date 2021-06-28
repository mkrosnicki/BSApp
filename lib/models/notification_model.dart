import 'package:BSApp/util/date_util.dart';

import 'notification_type.dart';

class NotificationModel {
  final String id;
  final String mainIssuerId;
  final String mainIssuerUsername;
  final int totalNumberOfIssuers;
  final DateTime issuedAt;
  final bool wasClicked;
  final NotificationType notificationType;
  final String relatedTopicId;
  final String relatedTopicTitle;
  final String relatedDealId;
  final String relatedDealTitle;
  final String relatedPostId;
  final String relatedPostContent;
  final String relatedParentCommentId;
  final String relatedCommentId;
  final String relatedCommentContent;

  NotificationModel(
      {this.id,
      this.mainIssuerId,
      this.mainIssuerUsername,
      this.totalNumberOfIssuers,
      this.issuedAt,
      this.wasClicked,
      this.notificationType,
      this.relatedTopicId,
      this.relatedTopicTitle,
      this.relatedDealId,
      this.relatedDealTitle,
      this.relatedPostId,
      this.relatedPostContent,
      this.relatedParentCommentId,
      this.relatedCommentId,
      this.relatedCommentContent});

  static List<NotificationModel> fromJsonList(List<dynamic> notificationsSnapshot) {
    final List<NotificationModel> notifications = [];
    for (final notificationSnapshot in notificationsSnapshot) {
      notifications.add(fromJson(notificationSnapshot));
    }
    return notifications;
  }

  static NotificationModel fromJson(dynamic notificationSnapshot) {
    print(notificationSnapshot);
    return NotificationModel(
      id: notificationSnapshot['id'],
      mainIssuerId: notificationSnapshot['mainIssuerId'],
      mainIssuerUsername: notificationSnapshot['mainIssuerUsername'],
      totalNumberOfIssuers: notificationSnapshot['totalNumberOfIssuers'],
      issuedAt: DateUtil.parseFromStringToUtc(notificationSnapshot['issuedAt']),
      wasClicked: notificationSnapshot['clickedAt'] != null,
      notificationType: NotificationTypeHelper.fromString(notificationSnapshot['notificationType']),
      relatedTopicId: notificationSnapshot['relatedTopicId'],
      relatedTopicTitle: notificationSnapshot['relatedTopicTitle'],
      relatedDealId: notificationSnapshot['relatedDealId'],
      relatedDealTitle: notificationSnapshot['relatedDealTitle'],
      relatedPostId: notificationSnapshot['relatedPostId'],
      relatedPostContent: notificationSnapshot['relatedPostContent'],
      relatedParentCommentId: notificationSnapshot['relatedParentCommentId'],
      relatedCommentId: notificationSnapshot['relatedCommentId'],
      relatedCommentContent: notificationSnapshot['relatedCommentContent'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NotificationModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'NotificationModel{id: $id, notificationType: $notificationType}';
  }
}
