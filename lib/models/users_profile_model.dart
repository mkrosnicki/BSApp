import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/user_model.dart';

import 'deal_model.dart';

class UsersProfileModel {
  final UserModel user;
  final List<DealModel> addedDeals;
  final List<TopicModel> addedTopics;
  final List<ActivityModel> activities;

  UsersProfileModel(
      {this.user, this.addedDeals, this.addedTopics, this.activities});

  static UsersProfileModel fromJson(dynamic profileSnapshot) {
    return UsersProfileModel(
      user: UserModel.fromJson(profileSnapshot['user']),
      addedDeals: (profileSnapshot['addedDeals'] as List)
          .map((e) => DealModel.fromJson(e))
          .toList(),
      addedTopics: (profileSnapshot['addedTopics'] as List)
          .map((e) => TopicModel.fromJson(e))
          .toList(),
      activities: (profileSnapshot['activities'] as List)
          .map((e) => ActivityModel.fromJson(e))
          .toList(),
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersProfileModel &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() {
    return 'UsersProfileModel{user: $user}';
  }
}
