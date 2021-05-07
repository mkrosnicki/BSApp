import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Categories with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories {
    return [..._categories];
  }

  Future<void> fetchCategories() async {
    if (_categories.isEmpty) {
      final List<CategoryModel> loadedCategories = [];
      final responseBody = await _apiProvider.get('/categories') as List;
      if (responseBody == null) {
        final logger = Logger();
        logger.e("No Categories Found!");
      }
      responseBody.forEach((element) {
        loadedCategories.add(CategoryModel.fromJson(element));
      });
      _categories = loadedCategories;
    }
  }

}