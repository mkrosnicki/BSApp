import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/city_model.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/models/voivodeship_model.dart';

class FilterSettings {
  static const SortingType DEFAULT_SORTING_TYPE = SortingType.NEWEST;
  static const bool DEFAULT_SHOW_ACTIVE_ONLY = false;
  static const bool DEFAULT_SHOW_INTERNET_ONLY = false;

  String phrase;
  List<CategoryModel> categories = [];
  bool showActiveOnly = DEFAULT_SHOW_ACTIVE_ONLY;
  bool showInternetOnly = DEFAULT_SHOW_INTERNET_ONLY;
  Voivodeship voivodeship;
  City city;
  List<AgeType> ageTypes = [];
  SortingType sortBy = DEFAULT_SORTING_TYPE;

  FilterSettings();

  FilterSettings.phrase(this.phrase);

  FilterSettings.categories(this.categories);

  CategoryModel get lastCategory {
    return categories.isNotEmpty ? categories[categories.length - 1] : null;
  }

  String get categoriesString {
    return categories.map((e) => e.name).join(" / ");
  }

  String get lastCategoryString {
    return lastCategory != null ? lastCategory.name : null;
  }

  String get locationString {
    return voivodeship != null
        ? '${voivodeship.name} / ${city != null ? city.name : 'Wszystkie miasta'}'
        : null;
  }

  String get simpleLocationString {
    return city != null ? city.name : voivodeship != null ? voivodeship.name : null;
  }

  String get sortingString {
    return sortBy != null ? 'Sortowanie: ${SortingTypeHelper.getReadableM(sortBy)}' : null;
  }

  String get ageTypesString {
    return ageTypes.map((e) => AgeTypeHelper.getReadable(e)).join(", ");
  }

  Map<String, dynamic> toParamsMap() {
    Map<String, dynamic> paramsMap = {};
    if (phrase != null) {
      paramsMap.putIfAbsent('phrase', () => phrase);
    }
    if (categories.isNotEmpty) {
      paramsMap.putIfAbsent('category', () => categories.last.id);
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

  clear(
      {bool clearInternetOnly = false,
      bool clearActiveOnly = false,
      bool clearLocation = false,
      bool clearSorting = false,
      bool clearPhrase = false,
      bool clearCategories = false,
      bool clearAgeTypes = false}) {

    if (clearInternetOnly) {
      this.clearInternetOnly();
    }
    if (clearActiveOnly) {
      this.clearActiveOnly();
    }
    if (clearLocation) {
      this.clearLocation();
    }
    if (clearSorting) {
      this.clearSorting();
    }
    if (clearPhrase) {
      this.clearPhrase();
    }
    if (clearCategories) {
      this.clearCategories();
    }
    if (clearAgeTypes) {
      this.clearAgeTypes();
    }
  }

  clearPhrase() {
    this.phrase = null;
  }

  clearInternetOnly() {
    this.showInternetOnly = DEFAULT_SHOW_INTERNET_ONLY;
  }

  clearActiveOnly() {
    this.showActiveOnly = DEFAULT_SHOW_ACTIVE_ONLY;
  }

  clearCategories() {
    this.categories = [];
  }

  clearAgeTypes() {
    this.ageTypes = [];
  }

  clearSorting() {
    this.sortBy = DEFAULT_SORTING_TYPE;
  }

  clearLocation() {
    this.voivodeship = null;
    this.city = null;
  }

  clearAll() {
    clearPhrase();
    clearInternetOnly();
    clearActiveOnly();
    clearCategories();
    clearAgeTypes();
    clearSorting();
    clearLocation();
  }

  bool areDefaults() {
    return showInternetOnly == DEFAULT_SHOW_INTERNET_ONLY &&
        showActiveOnly == DEFAULT_SHOW_ACTIVE_ONLY &&
        categories.isEmpty &&
        ageTypes.isEmpty &&
        sortBy == DEFAULT_SORTING_TYPE &&
        city == null &&
        voivodeship == null;
  }

  FilterSettings fromJson(Map<String, dynamic> json) {
    return null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dto = {
      'phrase': phrase,
      'categories': [],
      'ageTypes': [],
      'showActiveOnly': showActiveOnly.toString(),
      'showInternetOnly': showInternetOnly.toString(),
      'voivodeship': voivodeship != null ? voivodeship.toJson() : null,
      'city': city != null ? city.toJson() : null,
      'sortBy': [],
    };
    print(dto);
    return dto;
  }

  Map<String, dynamic> toSaveSearchDto() {
    Map<String, dynamic> dto = {
      'phrase': phrase,
      'categories': categories.map((e) => e.id).toList(),
      'ageTypes': ageTypes.map((e) => AgeTypeHelper.asString(e)).toList(),
      'showActiveOnly': showActiveOnly.toString(),
      'showInternetOnly': showInternetOnly.toString(),
      'voivodeship': voivodeship != null ? voivodeship.id : null,
      'city': city != null ? city.name : null,
      'sortBy': sortBy != null ? SortingTypeHelper.asString(this.sortBy) : null,
    };
    return dto;
  }

  @override
  String toString() {
    return 'FilterSettings{phrase: $phrase, categories: $categories, showActiveOnly: $showActiveOnly, showInternetOnly: $showInternetOnly, voivodeship: $voivodeship, city: $city, ageTypes: $ageTypes, sortBy: $sortBy}';
  }
}
