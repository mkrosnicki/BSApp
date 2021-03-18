import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';

class FilterSettings {

  String phrase;
  List<CategoryModel> categories = [];
  bool showActiveOnly = false;
  bool showInternetOnly = false;
  Voivodeship voivodeship;
  City city;
  List<AgeType> ageTypes = [];
  SortingType sortBy = SortingType.NEWEST;

  String get categoriesString {
    return categories.map((e) => e.name).join(" / ");
  }

  String get locationString {
    return voivodeship != null ? '${voivodeship.name} / ${city != null ? city.name : 'Wszystkie miasta'}' : null;
  }

  String get ageTypesString {
    return ageTypes.map((e) => AgeTypeHelper.getString(e)).join(", ");
  }

  Map<String, dynamic> toParamsMap() {
    Map<String, dynamic> paramsMap = {};
    if (phrase != null) {
      paramsMap.putIfAbsent('phrase', () => phrase);
    }
    if (categories.isNotEmpty) {
      paramsMap.putIfAbsent('categories', () => categories);
    }
    if (showActiveOnly) {
      paramsMap.putIfAbsent('showActiveOnly', () => showActiveOnly);
    }
    if (showInternetOnly) {
      paramsMap.putIfAbsent('showInternetOnly', () => showInternetOnly);
    }
    if (voivodeship != null) {
      paramsMap.putIfAbsent('voivodeship', () => voivodeship);
    }
    if (city != null) {
      paramsMap.putIfAbsent('city', () => city);
    }
    if (ageTypes.isNotEmpty) {
      paramsMap.putIfAbsent('ageTypes', () => ageTypes);
    }
    if (sortBy != null) {
      paramsMap.putIfAbsent('sortBy', () => sortBy);
    }
  }

}