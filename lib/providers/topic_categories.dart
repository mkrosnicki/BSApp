import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TopicCategories with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<TopicCategoryModel> _topicCategories = [];

  List<TopicCategoryModel> get topicCategories {
    return [..._topicCategories];
  }

  Future<void> fetchTopicCategories() async {
    if (_topicCategories.isEmpty) {
      final responseBody = await _apiProvider.get('/topic-categories') as List;
      if (responseBody == null) {
        final logger = Logger();
        logger.i('No Topic Categories Found!');
      }
      _topicCategories = TopicCategoryModel.fromJsonList(responseBody);
    }
  }
}
