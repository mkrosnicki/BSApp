import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/widgets/activities/activity_item.dart';
import 'package:flutter/material.dart';

class UserProfileActivitiesList extends StatelessWidget {
  final UsersProfileModel usersProfile;

  UserProfileActivitiesList(this.usersProfile);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(top: 6.0),
        child: ListView.builder(
          itemCount: usersProfile.activities.length,
          itemBuilder: (context, index) {
            return ActivityItem(usersProfile.activities[index]);
          },
        ),
      ),
    );
  }
}
