import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:collection/collection.dart';

class FilterSettings {
  static const SortingType DEFAULT_SORTING_TYPE = SortingType.NEWEST;
  static const bool DEFAULT_SHOW_ACTIVE_ONLY = false;
  static const bool DEFAULT_SHOW_INTERNET_ONLY = false;

  String phrase;
  CategoryModel category;
  bool showActiveOnly = DEFAULT_SHOW_ACTIVE_ONLY;
  bool showInternetOnly = DEFAULT_SHOW_INTERNET_ONLY;
  Voivodeship voivodeship;
  City city;
  List<AgeType> ageTypes = [];
  SortingType sortBy = DEFAULT_SORTING_TYPE;

  FilterSettings();

  FilterSettings.phrase(this.phrase);

  FilterSettings.category(this.category);

  FilterSettings.sort(this.sortBy);

  CategoryModel get lastCategory {
    return category;
  }

  String get categoryString {
    return category != null ? category.name : 'Wszystkie';
  }

  String get lastCategoryString {
    return lastCategory?.name;
  }

  String get locationString {
    return voivodeship != null
        ? '${voivodeship.name} / ${city != null ? city.name : 'Wszystkie miasta'}'
        : null;
  }

  String get simpleLocationString {
    return city != null ? city.name : voivodeship?.name;
  }

  String get sortingString {
    return sortBy != null ? SortingTypeHelper.getReadableM(sortBy) : null;
  }

  String get ageTypesString {
    return ageTypes.map((e) => AgeTypeHelper.getReadable(e)).join(", ");
  }

  String get ageTypesShortString {
    return ageTypes.length >  1 ?
      '${AgeTypeHelper.getReadable(ageTypes[0])}, ...' :
      ageTypesString;
  }

  Map<String, dynamic> toParamsMap() {
    final Map<String, dynamic> paramsMap = {};
    if (phrase != null) {
      paramsMap.putIfAbsent('phrase', () => phrase);
    }
    if (category != null) {
      paramsMap.putIfAbsent('category', () => category.id);
    }
    if (showActiveOnly) {
      paramsMap.putIfAbsent('showActiveOnly', () => showActiveOnly.toString());
    }
    if (showInternetOnly) {
      paramsMap.putIfAbsent(
          'showInternetOnly', () => showInternetOnly.toString());
    }
    if (voivodeship != null) {
      paramsMap.putIfAbsent('voivodeship', () => voivodeship.id);
    }
    if (city != null) {
      paramsMap.putIfAbsent('city', () => city.name);
    }
    if (ageTypes.isNotEmpty) {
      paramsMap.putIfAbsent(
          'ageTypes', () => AgeTypeHelper.asParamString(ageTypes));
    }
    if (sortBy != null) {
      paramsMap.putIfAbsent('sortBy', () => SortingTypeHelper.asString(sortBy));
    }
    return paramsMap;
  }

  void clear(
      {bool clearInternetOnly = false,
      bool clearActiveOnly = false,
      bool clearLocation = false,
      bool clearSorting = false,
      bool clearPhrase = false,
      bool clearCategories = false,
      bool clearAgeTypes = false}) {

    if (clearInternetOnly) {
      _clearInternetOnly();
    }
    if (clearActiveOnly) {
      _clearActiveOnly();
    }
    if (clearLocation) {
      _clearLocation();
    }
    if (clearSorting) {
      _clearSorting();
    }
    if (clearPhrase) {
      _clearPhrase();
    }
    if (clearCategories) {
      _clearCategories();
    }
    if (clearAgeTypes) {
      _clearAgeTypes();
    }
  }

  void _clearPhrase() {
    phrase = null;
  }

  void _clearInternetOnly() {
    showInternetOnly = DEFAULT_SHOW_INTERNET_ONLY;
  }

  void _clearActiveOnly() {
    showActiveOnly = DEFAULT_SHOW_ACTIVE_ONLY;
  }

  void _clearCategories() {
    category = null;
  }

  void _clearAgeTypes() {
    ageTypes = [];
  }

  void _clearSorting() {
    sortBy = DEFAULT_SORTING_TYPE;
  }

  void _clearLocation() {
    voivodeship = null;
    city = null;
  }

  void clearAll() {
    _clearPhrase();
    _clearInternetOnly();
    _clearActiveOnly();
    _clearCategories();
    _clearAgeTypes();
    _clearSorting();
    _clearLocation();
  }

  int filtersCount() {
    int count = 0;
    if (showInternetOnly != DEFAULT_SHOW_INTERNET_ONLY) {
      count++;
    }
    if (showActiveOnly != DEFAULT_SHOW_ACTIVE_ONLY) {
      count++;
    }
    if (category != null) {
      count++;
    }
    if (ageTypes.isNotEmpty) {
      count++;
    }
    if (sortBy != DEFAULT_SORTING_TYPE) {
      count++;
    }
    if (city != null || voivodeship != null) {
      count++;
    }
    return count;
  }

  bool areDefaults() {
    return filtersCount() == 0;
  }

  static FilterSettings fromJson(Map<String, dynamic> json) {
    final FilterSettings newFilterSettings = FilterSettings();
    newFilterSettings.phrase = json['phrase'];
    newFilterSettings.category = CategoryModel.fromJson(json['category']);
    newFilterSettings.ageTypes = (json['ageTypes'] as List).map((e) => AgeTypeHelper.fromString(e)).toList();
    newFilterSettings.voivodeship = Voivodeship.fromJson(json['voivodeship']);
    newFilterSettings.city = City.fromJson(json['city']);
    newFilterSettings.showActiveOnly = json['showActiveOnly'] as bool;
    newFilterSettings.showInternetOnly = json['showInternetOnly'] as bool;
    newFilterSettings.sortBy = SortingTypeHelper.fromString(json['sortBy']);
    return newFilterSettings;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'phrase': phrase,
      'category': category.toJson(),
      'ageTypes': ageTypes.map((e) => AgeTypeHelper.asString(e)).toList(),
      'showActiveOnly': showActiveOnly,
      'showInternetOnly': showInternetOnly,
      'voivodeship': voivodeship?.toJson(),
      'city': city?.toJson(),
      'sortBy': sortBy != null ? SortingTypeHelper.asString(sortBy) : null,
    };
    return json;
  }

  Map<String, dynamic> toSaveSearchDto() {
    Map<String, dynamic> dto = {
      'phrase': phrase,
      'category': category.id,
      'ageTypes': ageTypes.map((e) => AgeTypeHelper.asString(e)).toList(),
      'showActiveOnly': showActiveOnly.toString(),
      'showInternetOnly': showInternetOnly.toString(),
      'voivodeship': voivodeship?.id,
      'city': city?.name,
      'sortBy': sortBy != null ? SortingTypeHelper.asString(this.sortBy) : null,
    };
    return dto;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterSettings &&
          runtimeType == other.runtimeType &&
          phrase == other.phrase &&
          const DeepCollectionEquality.unordered().equals(category, other.category) &&
          showActiveOnly == other.showActiveOnly &&
          showInternetOnly == other.showInternetOnly &&
          voivodeship == other.voivodeship &&
          city == other.city &&
          const DeepCollectionEquality.unordered().equals(ageTypes, other.ageTypes) &&
          sortBy == other.sortBy;

  @override
  int get hashCode =>
      phrase.hashCode ^
      category.hashCode ^
      showActiveOnly.hashCode ^
      showInternetOnly.hashCode ^
      voivodeship.hashCode ^
      city.hashCode ^
      ageTypes.hashCode ^
      sortBy.hashCode;

  @override
  String toString() {
    return 'FilterSettings{phrase: $phrase, category: $category, showActiveOnly: $showActiveOnly, showInternetOnly: $showInternetOnly, voivodeship: $voivodeship, city: $city, ageTypes: $ageTypes, sortBy: $sortBy}';
  }
}
