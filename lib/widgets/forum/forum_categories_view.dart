import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/providers/topic_categories.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forum_category_item.dart';

class ForumCategoriesView extends StatelessWidget {
  List<TopicCategoryModel> _allCategories;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: _initCategories(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: _allCategories
                        .map((e) => ForumCategoryItem(e))
                        .toList(),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<void> _initCategories(BuildContext context) {
    if (_allCategories == null) {
      return Provider.of<TopicCategories>(context, listen: false)
          .fetchTopicCategories()
          .then((_) {
        _allCategories = Provider.of<TopicCategories>(context, listen: false)
            .topicCategories;
      });
    } else {
      return Future(() => {});
    }
  }
}
