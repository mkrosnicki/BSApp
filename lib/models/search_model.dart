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
  CategoryModel category;
  bool showActiveOnly;
  bool showInternetOnly;
  Voivodeship voivodeship;
  City city;
  List<AgeType> ageTypes;
  SortingType sortBy;

  SearchModel(
      {this.id,
      this.phrase,
      this.category,
      this.showActiveOnly,
      this.showInternetOnly,
      this.voivodeship,
      this.city,
      this.ageTypes,
      this.sortBy});

  static List<SearchModel> fromJsonList(List<dynamic> searchesSnapshot) {
    final List<SearchModel> searches = [];
    for (final searchSnapshot in searchesSnapshot) {
      searches.add(fromJson(searchSnapshot));
    }
    return searches;
  }

  static SearchModel fromJson(dynamic searchSnapshot) {
    return SearchModel(
      id: searchSnapshot['id'],
      phrase: searchSnapshot['phrase'],
      category: CategoryModel.fromJson(searchSnapshot['category']),
      showActiveOnly: searchSnapshot['showActiveOnly'],
      showInternetOnly: searchSnapshot['showInternetOnly'],
      voivodeship: Voivodeship.fromJson(searchSnapshot['voivodeship']),
      city: City.fromJson(searchSnapshot['city']),
      ageTypes: (searchSnapshot['ageTypes'] as List).map((e) => AgeTypeHelper.fromString(e)).toList(),
      sortBy: SortingTypeHelper.fromString(searchSnapshot['sortBy']),
    );
  }

  FilterSettings toFilterSettings() {
    final FilterSettings filterSettings = FilterSettings();
    filterSettings.phrase = phrase;
    filterSettings.category = category;
    filterSettings.ageTypes = ageTypes;
    filterSettings.showActiveOnly = showActiveOnly;
    filterSettings.showInternetOnly = showInternetOnly;
    filterSettings.voivodeship = voivodeship;
    filterSettings.city = city;
    filterSettings.sortBy = sortBy;
    return filterSettings;
  }

  bool isSame(FilterSettings filterSettings) {
    final Function eq = const DeepCollectionEquality.unordered().equals;
    return
      phrase == filterSettings.phrase &&
          eq(category, filterSettings.category) &&
          showActiveOnly == filterSettings.showActiveOnly &&
          showInternetOnly == filterSettings.showInternetOnly &&
          voivodeship == filterSettings.voivodeship &&
          city == filterSettings.city &&
          eq(ageTypes, filterSettings.ageTypes) &&
          sortBy == filterSettings.sortBy;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SearchModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'SearchModel{id: $id, phrase: $phrase, categories: $category, showActiveOnly: $showActiveOnly, showInternetOnly: $showInternetOnly, voivodeship: $voivodeship, city: $city, ageTypes: $ageTypes, sortBy: $sortBy}';
  }
}