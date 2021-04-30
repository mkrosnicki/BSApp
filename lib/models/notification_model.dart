import 'notification_type.dart';

class NotificationModel {
  final String id;
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
      {this.id,
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

  static NotificationModel fromJson(dynamic activitySnapshot) {
    return NotificationModel(
      id: activitySnapshot['id'],
      mainIssuerId: activitySnapshot['mainIssuerId'],
      mainIssuerUsername: activitySnapshot['mainIssuerUsername'],
      totalNumberOfIssuers: activitySnapshot['totalNumberOfIssuers'],
      issuedAt: DateTime.parse(activitySnapshot['issuedAt']),
      notificationType: NotificationTypeHelper.fromString(
          activitySnapshot['notificationType']),
      relatedTopicId: activitySnapshot['relatedTopicId'],
      relatedTopicTitle: activitySnapshot['relatedTopicTitle'],
      relatedDealId: activitySnapshot['relatedDealId'],
      relatedDealTitle: activitySnapshot['relatedDealTitle'],
      relatedPostId: activitySnapshot['relatedPostId'],
      relatedPostContent: activitySnapshot['relatedPostContent'],
      relatedCommentId: activitySnapshot['relatedCommentId'],
      relatedCommentContent: activitySnapshot['relatedCommentContent'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'NotificationModel{id: $id, mainIssuerId: $mainIssuerId, mainIssuerUsername: $mainIssuerUsername, totalNumberOfIssuers: $totalNumberOfIssuers, issuedAt: $issuedAt, notificationType: $notificationType, relatedTopicId: $relatedTopicId, relatedTopicTitle: $relatedTopicTitle, relatedDealId: $relatedDealId, relatedDealTitle: $relatedDealTitle, relatedPostId: $relatedPostId, relatedPostContent: $relatedPostContent, relatedCommentId: $relatedCommentId, relatedCommentContent: $relatedCommentContent}';
  }
}
