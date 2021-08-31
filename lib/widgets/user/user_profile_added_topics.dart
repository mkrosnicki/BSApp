import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileAddedTopics extends StatelessWidget {
  final String userId;

  const UserProfileAddedTopics(this.userId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Topics>(context, listen: false).fetchTopicsAddedBy(userId),
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
                    ? Container(
                        color: MyColorsProvider.BACKGROUND_COLOR,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => TopicItem(topicsData.topics[index]),
                          itemCount: topicsData.topics.length,
                        ))
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
          'Brak dodanych tematów',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
