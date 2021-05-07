import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourTopicsScreen extends StatelessWidget {
  static const routeName = '/added-topics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.black),
        title: 'Twoje tematy',
      ),
      body: FutureBuilder(
        future:
            Provider.of<CurrentUser>(context, listen: false).fetchAddedTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: ServerErrorSplash(),
              );
            } else {
              return Consumer<CurrentUser>(
                builder: (context, currentUserData, child) {
                  return currentUserData.addedTopics.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) =>
                              TopicItem(currentUserData.addedTopics[index]),
                          itemCount: currentUserData.addedTopics.length,
                        )
                      : _buildNoStartedTopicsSplashView();
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildNoStartedTopicsSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Brak tematów',
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
