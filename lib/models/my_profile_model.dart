
import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/models/user_details_model.dart';

import 'deal_model.dart';

class MyProfileModel {
  final UserDetailsModel user;
  final List<SearchModel> observedSearches;
  final List<String> observedTopics;
  final List<String> observedDeals;

  MyProfileModel(
      {this.user,
      this.observedSearches,
      this.observedDeals,
      this.observedTopics});

  static MyProfileModel fromJson(dynamic userSnapshot) {
    print(userSnapshot);
    return MyProfileModel(
      user: UserDetailsModel.fromJson(userSnapshot['user']),
      observedSearches: (userSnapshot['observedSearches'] as List)
          .map((e) => SearchModel.fromJson(e))
          .toList(),
      observedDeals: [...userSnapshot['observedDeals'] as List],
      observedTopics: [...userSnapshot['observedTopics'] as List],
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
