import 'package:BSApp/providers/activities.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/activities/activity_item.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileActivitiesList extends StatelessWidget {
  final String userId;

  const UserProfileActivitiesList(this.userId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Activities>(context, listen: false).fetchUsersActivities(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            return Consumer<Activities>(
              builder: (context, activitiesData, child) {
                return activitiesData.activities.isNotEmpty
                    ? Container(
                  color: MyColorsProvider.BACKGROUND_COLOR,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ActivityItem(activitiesData.activities[index]),
                    itemCount: activitiesData.activities.length,
                  ),
                )
                    : _buildNoAddedDealsSplashView();
              },
            );
          }
        }
      },
    );
  }

  Widget _buildNoAddedDealsSplashView() {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      height: 500,
      width: double.infinity,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.only(top: 120.0),
        child: Text(
          'Brak aktywności',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
