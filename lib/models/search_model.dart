import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:collection/collection.dart';

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
    var voivodeship = searchSnapshot['voivodeship'];
    var city = searchSnapshot['city'];
    return SearchModel(
      id: searchSnapshot['id'],
      phrase: searchSnapshot['phrase'],
      categories: (searchSnapshot['categories'] as List).map((e) => CategoryModel.of(e)).toList(),
      showActiveOnly: searchSnapshot['showActiveOnly'],
      showInternetOnly: searchSnapshot['showInternetOnly'],
      voivodeship: voivodeship != null ? Voivodeship.of(searchSnapshot['voivodeship']) : null,
      city: city != null ? City.of(searchSnapshot['city']) : null,
      ageTypes: (searchSnapshot['ageTypes'] as List).map((e) => AgeTypeHelper.fromString(e)).toList(),
      sortBy: SortingTypeHelper.fromString(searchSnapshot['sortBy']),
    );
  }

  FilterSettings toFilterSettings() {
    var filterSettings = new FilterSettings();
    filterSettings.phrase = phrase;
    filterSettings.categories = categories;
    filterSettings.ageTypes = ageTypes;
    filterSettings.showActiveOnly = showActiveOnly;
    filterSettings.showInternetOnly = showInternetOnly;
    filterSettings.voivodeship = voivodeship;
    filterSettings.city = city;
    filterSettings.sortBy = sortBy;
    return filterSettings;
  }

  bool isSame(FilterSettings filterSettings) {
    Function eq = const ListEquality().equals;
    return
      phrase == filterSettings.phrase &&
          eq(categories, filterSettings.categories) &&
          showActiveOnly == filterSettings.showActiveOnly &&
          showInternetOnly == filterSettings.showInternetOnly &&
          voivodeship == filterSettings.voivodeship &&
          city == filterSettings.city &&
          eq(ageTypes, filterSettings.ageTypes) &&
          sortBy == filterSettings.sortBy;
  }
}