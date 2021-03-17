import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';

class FilterSettings {

  String phrase;
  List<CategoryModel> categories;
  bool showActiveOnly = false;
  Voivodeship voivodeship;
  City city;

  String get categoriesString {
    return categories.map((e) => e.name).join(" / ");
  }

  String get locationString {
    return voivodeship != null ? '${voivodeship.name} / ${city != null ? city.name : 'Wszystkie miasta'}' : null;
  }

}