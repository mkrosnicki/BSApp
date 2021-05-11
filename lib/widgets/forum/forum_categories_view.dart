import 'package:BSApp/providers/topic_categories.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forum_category_item.dart';

class ForumCategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: Provider.of<TopicCategories>(context, listen: false)
              .fetchTopicCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return Consumer<TopicCategories>(
                  builder: (context, topicCategoriesData, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: topicCategoriesData.topicCategories
                            .map((e) => ForumCategoryItem(e))
                            .toList(),
                      ),
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
