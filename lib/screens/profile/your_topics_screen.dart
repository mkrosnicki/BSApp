import 'package:BSApp/providers/topics.dart';
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
        leading: AppBarBackButton(Colors.white),
        title: 'Twoje tematy',
      ),
      body: FutureBuilder(
        future: Provider.of<Topics>(context, listen: false).fetchAddedTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: ServerErrorSplash(),
              );
            } else {
              return Consumer<Topics>(
                builder: (context, topicsData, child) {
                  return topicsData.topics.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) =>
                              TopicItem(topicsData.topics[index]),
                          itemCount: topicsData.topics.length,
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
