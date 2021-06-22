
import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/user_details_model.dart';

import 'deal_model.dart';

class MyProfileModel {
  final UserDetailsModel user;
  final List<SearchModel> observedSearches;
  final List<TopicModel> observedTopics;
  final List<DealModel> observedDeals;

  MyProfileModel(
      {this.user,
      this.observedSearches,
      this.observedDeals,
      this.observedTopics});

  static MyProfileModel fromJson(dynamic userSnapshot) {
    return MyProfileModel(
      user: MyProfileModel.fromJson(userSnapshot['user']),
      observedSearches: (userSnapshot['observedSearches'] as List)
          .map((e) => SearchModel.fromJson(e))
          .toList(),
      observedTopics: (userSnapshot['observedTopics'] as List)
          .map((e) => TopicModel.fromJson(e))
          .toList(),
      observedDeals: (userSnapshot['observedDeals'] as List)
          .map((e) => DealModel.fromJson(e))
          .toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyProfileModel &&
          runtimeType == other.runtimeType &&
          user.id == other.user.id;

  @override
  int get hashCode => user.id.hashCode;
}
