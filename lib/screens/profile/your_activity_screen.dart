import 'package:BSApp/providers/activities.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/activities/activity_item.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourActivityScreen extends StatelessWidget {
  static const routeName = '/your-activity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.white),
        title: 'Twoja aktywność',
      ),
      body: FutureBuilder(
        future:
            Provider.of<Activities>(context, listen: false).fetchMyActivities(),
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
                builder: (context, currentUserData, child) {
                  return currentUserData.activities.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) =>
                              ActivityItem(currentUserData.activities[index]),
                          itemCount: currentUserData.activities.length,
                        )
                      : _buildNoActivitiesSplashView();
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildNoActivitiesSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nie masz jeszcze żadnej aktywności',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
