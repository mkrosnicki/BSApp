import 'package:BSApp/models/topic_category_model.dart';
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
    final TopicCategoryModel topicCategory = ModalRoute.of(context).settings.arguments as TopicCategoryModel;
    return Scaffold(
      appBar: BaseAppBar(
        title: topicCategory.name,
        leading: const AppBarBackButton(Colors.white),
        actions: [
          AppBarAddTopicButton(topicCategory),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<Topics>(context, listen: false)
              .fetchCategoryTopics(topicCategory.id),
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
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return TopicItem(topicsData.topics[index]);
                      },
                      itemCount: topicsData.topics.length,
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
