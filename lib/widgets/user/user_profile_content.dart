import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/widgets/user/user_profile_activities_list.dart';
import 'package:BSApp/widgets/user/user_profile_added_deals.dart';
import 'package:BSApp/widgets/user/user_profile_added_topics.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


class UserProfileContent extends StatelessWidget {
  final PublishSubject<int> contentIdSubject;
  final UsersProfileModel usersProfile;

  Stream<int> get _contentIdStream => contentIdSubject.stream;

  const UserProfileContent(this.usersProfile, this.contentIdSubject);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _contentIdStream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        final int contentId = snapshot.data ?? 0;
        if (contentId == 0) {
          return UserProfileActivitiesList(usersProfile);
        } else if (contentId == 1) {
          return UserProfileAddedDeals(usersProfile.addedDeals);
        } else if (contentId == 2) {
          return UserProfileAddedTopics(usersProfile.addedTopics);
        } else {
          return const Text('Error');
        }
      },
    );
  }
}
