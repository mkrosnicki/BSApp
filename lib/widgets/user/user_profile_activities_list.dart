import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/widgets/activities/activity_item.dart';
import 'package:flutter/material.dart';

class UserProfileActivitiesList extends StatelessWidget {
  UsersProfileModel usersProfile;

  UserProfileActivitiesList(this.usersProfile);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
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
