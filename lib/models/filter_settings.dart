import 'package:BSApp/models/category_model.dart';

class FilterSettings {

  String phrase;
  List<CategoryModel> categories;

  String get categoriesString {
    return categories.map((e) => e.name).join(" / ");
  }

}