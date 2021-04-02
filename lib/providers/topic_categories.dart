import 'package:BSApp/models/topic_category_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class TopicCategories with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<TopicCategoryModel> _topicCategories = [];

  List<TopicCategoryModel> get topicCategories {
    return [..._topicCategories];
  }

  Future<void> fetchTopicCategories() async {
    if (_topicCategories.isEmpty) {
      final List<TopicCategoryModel> loadedCategories = [];
      final responseBody = await _apiProvider.get('/topic-categories') as List;
      if (responseBody == null) {
        print('No Topic Categories Found!');
      }
      responseBody.forEach((element) {
        loadedCategories.add(TopicCategoryModel.of(element));
      });
      _topicCategories = loadedCategories;
    }
    notifyListeners();
  }
}
