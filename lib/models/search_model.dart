import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';

import 'age_type.dart';
import 'category_model.dart';
import 'city_model.dart';

class SearchModel {

  String id;
  String phrase;
  List<CategoryModel> categories;
  bool showActiveOnly;
  bool showInternetOnly;
  Voivodeship voivodeship;
  City city;
  List<AgeType> ageTypes;
  SortingType sortBy;

  SearchModel(
      {this.id,
      this.phrase,
      this.categories,
      this.showActiveOnly,
      this.showInternetOnly,
      this.voivodeship,
      this.city,
      this.ageTypes,
      this.sortBy});

  static SearchModel of(dynamic searchSnapshot) {
    return SearchModel(
      id: searchSnapshot['id'],
      phrase: searchSnapshot['phrase'],
      categories: (searchSnapshot['categories'] as List).map((e) => CategoryModel.of(e)).toList(),
      showActiveOnly: bool.fromEnvironment(searchSnapshot['showActiveOnly']),
      showInternetOnly: bool.fromEnvironment(searchSnapshot['showInternetOnly']),
      voivodeship: Voivodeship.of(searchSnapshot['voivodeship']),
      city: City.of(searchSnapshot['city']),
      ageTypes: (searchSnapshot['ageTypes'] as List).map((e) => AgeTypeHelper.fromString(e)).toList(),
      sortBy: SortingTypeHelper.fromString(searchSnapshot['sortBy']),
    );
  }
}