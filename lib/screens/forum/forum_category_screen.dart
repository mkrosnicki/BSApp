import 'package:BSApp/models/topic_model.dart';
import 'package:BSApp/providers/topics.dart';
import 'package:BSApp/widgets/bars/app_bar_add_topic_button.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/forum/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForumCategoryScreen extends StatelessWidget {
  static const routeName = '/forum-category';

  @override
  Widget build(BuildContext context) {
    final String categoryId = ModalRoute.of(context).settings.arguments as String;
    final normalTopicsHeader = Container(
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        'Tematy',
        style: TextStyle(fontSize: 15),
      ),
    );
    final pinnedTopicsHeader = Container(
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        'Przypięte tematy',
        style: TextStyle(fontSize: 15),
      ),
    );
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Tematy',
        leading: const AppBarBackButton(Colors.black),
        actions: [
          AppBarAddTopicButton(Colors.black, categoryId),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<Topics>(context, listen: false)
              .fetchCategoryTopics(categoryId),
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
                    final List<TopicModel> pinnedTopics =
                        topicsData.categoryTopicsPinned;
                    final List<TopicModel> notPinnedTopics =
                        topicsData.categoryTopicsNotPinned;
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (pinnedTopics.isNotEmpty && index == 0) {
                          return pinnedTopicsHeader;
                        } else if (pinnedTopics.isEmpty && index == 0) {
                          return normalTopicsHeader;
                        } else if (pinnedTopics.isNotEmpty &&
                            index < pinnedTopics.length + 1) {
                          return TopicItem(pinnedTopics[index - 1]);
                        } else if (pinnedTopics.isNotEmpty &&
                            index == pinnedTopics.length + 1) {
                          return normalTopicsHeader;
                        } else if (pinnedTopics.isNotEmpty &&
                            index > pinnedTopics.length + 1) {
                          return TopicItem(
                              notPinnedTopics[index - pinnedTopics.length - 2]);
                        } else {
                          return TopicItem(notPinnedTopics[index - 1]);
                        }
                      },
                      itemCount: topicsData.categoryTopicsPinned.isNotEmpty
                          ? topicsData.categoryTopics.length + 2
                          : topicsData.categoryTopics.length + 1,
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
