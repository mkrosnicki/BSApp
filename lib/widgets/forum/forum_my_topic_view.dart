import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/login_to_continue_splash.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumMyTopicsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CurrentUser>(builder: (context, currentUser, child) {
        if (currentUser.isAuthenticated) {
          return FutureBuilder(
            future: Provider.of<Topics>(context, listen: false).fetchObservedTopics(),
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
                      final List<TopicModel> observedTopics =
                          topicsData.topics.where((element) => currentUser.observesTopic(element)).toList();
                      return topicsData.topics.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) => TopicItem(observedTopics[index]),
                              itemCount: observedTopics.length,
                            )
                          : _buildNoObservedTopicsView();
                    },
                  );
                }
              }
            },
          );
        } else {
          return const LoginToContinueSplash('Zaloguj się, aby zobaczyć\n zapisane tematy');
        }
      }),
    );
  }

  Widget _buildNoObservedTopicsView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nie obserwujesz żadnych tematów',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
