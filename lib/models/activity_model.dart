import 'package:BSApp/util/date_util.dart';

import 'activity_type.dart';

class ActivityModel {
  final String id;
  final String issuedById;
  final String issuedByUsername;
  final DateTime issuedAt;
  final ActivityType activityType;
  final String relatedDealId;
  final String relatedDealTitle;
  final String relatedCommentId;
  final String relatedCommentParentId;
  final String relatedCommentContent;
  final String relatedTopicId;
  final String relatedTopicTitle;
  final String relatedPostId;
  final String relatedPostContent;

  ActivityModel(
      {this.id,
      this.issuedById,
      this.issuedByUsername,
      this.issuedAt,
      this.activityType,
      this.relatedDealId,
      this.relatedDealTitle,
      this.relatedCommentId,
      this.relatedCommentParentId,
      this.relatedCommentContent,
      this.relatedTopicId,
      this.relatedTopicTitle,
      this.relatedPostId,
      this.relatedPostContent
      });

  static List<ActivityModel> fromJsonList(List<dynamic> activitiesSnapshot) {
    final List<ActivityModel> activities = [];
    for (final activitySnapshot in activitiesSnapshot) {
      activities.add(fromJson(activitySnapshot));
    }
    return activities;
  }

  static ActivityModel fromJson(dynamic activitySnapshot) {
    print(activitySnapshot);
    return ActivityModel(
      id: activitySnapshot['id'],
      issuedById: activitySnapshot['issuedById'],
      issuedByUsername: activitySnapshot['issuedByUsername'],
      issuedAt: DateUtil.parseFromStringToUtc(activitySnapshot['issuedAt']),
      activityType: ActivityTypeHelper.fromString(activitySnapshot['activityType']),
      relatedDealId: activitySnapshot['relatedDealId'],
      relatedDealTitle: activitySnapshot['relatedDealTitle'],
      relatedCommentId: activitySnapshot['relatedCommentId'],
      relatedCommentParentId: activitySnapshot['relatedCommentParentId'],
      relatedCommentContent: activitySnapshot['relatedCommentContent'],
      relatedTopicId: activitySnapshot['relatedTopicId'],
      relatedTopicTitle: activitySnapshot['relatedTopicTitle'],
      relatedPostId: activitySnapshot['relatedPostId'],
      relatedPostContent: activitySnapshot['relatedPostContent'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ActivityModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ActivityModel{id: $id, issuedById: $issuedById, issuedByUsername: $issuedByUsername, issuedAt: $issuedAt, activityType: $activityType}';
  }
}
