import 'package:BSApp/models/topic_model.dart';

import 'activity_type.dart';

class ActivityModel {
  final String id;
  final String issuedById;
  final String issuedByUsername;
  final DateTime issuedAt;
  final ActivityType activityType;
  final TopicModel relatedTopic;

  ActivityModel(
      {this.id,
      this.issuedById,
      this.issuedByUsername,
      this.issuedAt,
      this.activityType,
      this.relatedTopic});

  static ActivityModel fromJson(dynamic activitySnapshot) {
    return ActivityModel(
      id: activitySnapshot['id'],
      issuedById: activitySnapshot['issuedById'],
      issuedByUsername: activitySnapshot['issuedByUsername'],
      issuedAt: DateTime.parse(activitySnapshot['issuedAt']),
      activityType:
          ActivityTypeHelper.fromString(activitySnapshot['activityType']),
      relatedTopic: TopicModel.fromJson(activitySnapshot['relatedTopic']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ActivityModel{id: $id, issuedById: $issuedById, issuedByUsername: $issuedByUsername, issuedAt: $issuedAt, activityType: $activityType}';
  }
}
