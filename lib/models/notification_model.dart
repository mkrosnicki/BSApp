import 'notification_type.dart';

class NotificationModel {
  final List<String> ids;
  final String mainIssuerId;
  final String mainIssuerUsername;
  final int totalNumberOfIssuers;
  final DateTime issuedAt;
  final NotificationType notificationType;
  final String relatedTopicId;
  final String relatedTopicTitle;
  final String relatedDealId;
  final String relatedDealTitle;
  final String relatedPostId;
  final String relatedPostContent;
  final String relatedCommentId;
  final String relatedCommentContent;

  NotificationModel(
      {this.ids,
      this.mainIssuerId,
      this.mainIssuerUsername,
      this.totalNumberOfIssuers,
      this.issuedAt,
      this.notificationType,
      this.relatedTopicId,
      this.relatedTopicTitle,
      this.relatedDealId,
      this.relatedDealTitle,
      this.relatedPostId,
      this.relatedPostContent,
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
    return NotificationModel(
      ids: (notificationSnapshot['ids'] as List).map((e) => e.toString()).toList(),
      mainIssuerId: notificationSnapshot['mainIssuerId'],
      mainIssuerUsername: notificationSnapshot['mainIssuerUsername'],
      totalNumberOfIssuers: notificationSnapshot['totalNumberOfIssuers'],
      issuedAt: DateTime.parse(notificationSnapshot['issuedAt']),
      notificationType: NotificationTypeHelper.fromString(
          notificationSnapshot['notificationType']),
      relatedTopicId: notificationSnapshot['relatedTopicId'],
      relatedTopicTitle: notificationSnapshot['relatedTopicTitle'],
      relatedDealId: notificationSnapshot['relatedDealId'],
      relatedDealTitle: notificationSnapshot['relatedDealTitle'],
      relatedPostId: notificationSnapshot['relatedPostId'],
      relatedPostContent: notificationSnapshot['relatedPostContent'],
      relatedCommentId: notificationSnapshot['relatedCommentId'],
      relatedCommentContent: notificationSnapshot['relatedCommentContent'],
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          ids == other.ids;

  @override
  int get hashCode => ids.hashCode;

  @override
  String toString() {
    return 'NotificationModel{ids: $ids, issuedAt: $issuedAt, notificationType: $notificationType, relatedTopicId: $relatedTopicId, relatedDealId: $relatedDealId, relatedPostId: $relatedPostId}';
  }
}
