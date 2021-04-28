import 'package:BSApp/models/comment_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/post_model.dart';
import 'package:BSApp/models/topic_model.dart';

import 'activity_type.dart';

class ActivityModel {
  final String id;
  final String issuedById;
  final String issuedByUsername;
  final DateTime issuedAt;
  final ActivityType activityType;
  final TopicModel relatedTopic;
  final DealModel relatedDeal;
  final PostModel relatedPost;
  final CommentModel relatedComment;

  ActivityModel(
      {this.id,
      this.issuedById,
      this.issuedByUsername,
      this.issuedAt,
      this.activityType,
      this.relatedTopic,
      this.relatedDeal,
      this.relatedPost,
      this.relatedComment});

  static ActivityModel fromJson(dynamic activitySnapshot) {
    print(activitySnapshot['relatedPost']);
    print(activitySnapshot['relatedDeal']);
    print(activitySnapshot['relatedTopic']);
    print(activitySnapshot['relatedComment']);
    return ActivityModel(
      id: activitySnapshot['id'],
      issuedById: activitySnapshot['issuedById'],
      issuedByUsername: activitySnapshot['issuedByUsername'],
      issuedAt: DateTime.parse(activitySnapshot['issuedAt']),
      activityType:
          ActivityTypeHelper.fromString(activitySnapshot['activityType']),
      relatedTopic: TopicModel.fromJson(activitySnapshot['relatedTopic']),
      relatedDeal: DealModel.fromJson(activitySnapshot['relatedDeal']),
      relatedPost: PostModel.fromJson(activitySnapshot['relatedPost']),
      relatedComment: CommentModel.fromJson(activitySnapshot['relatedComment']),
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
