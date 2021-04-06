import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';

import 'category_model.dart';

class AddDealModel {

  DealType _dealType;
  String _title;
  String _urlLocation;
  String _description;
  String _locationDescription;
  List<CategoryModel> _categories = [];
  List<AgeType> _ageTypes = [];
  LocationType _locationType;
  String _voivodeship;
  String _city;
  DateTime _validFrom;
  DateTime _validTo;
  String _dealCode;
  double _discountValue;
  double _regularPrice;
  double _currentPrice;
  double _shippingPrice;

  DateTime get validFrom => _validFrom;

  DateTime get validTo => _validTo;

  List<CategoryModel> get categories => _categories;

  List<AgeType> get ageTypes => _ageTypes;

  String get city => _city;

  LocationType get locationType => _locationType;

  String get voivodeship => _voivodeship;

  set dealType(DealType value) {
    _dealType = value;
  }

  set title(String value) {
    _title = value;
  }

  set urlLocation(String value) {
    _urlLocation = value;
  }

  set description(String value) {
    _description = value;
  }

  set locationDescription(String value) {
    _locationDescription = value;
  }

  set categories(List<CategoryModel> value) {
    _categories = value;
  }

  set locationType(LocationType value) {
    _locationType = value;
  }

  set city(String value) {
    _city = value;
  }

  set validFrom(DateTime value) {
    _validFrom = value;
  }

  set validTo(DateTime value) {
    _validTo = value;
  }

  set dealCode(String value) {
    _dealCode = value;
  }

  set discountValue(double value) {
    _discountValue = value;
  }

  set regularPrice(double value) {
    _regularPrice = value;
  }

  set currentPrice(double value) {
    _currentPrice = value;
  }

  set shippingPrice(double value) {
    _shippingPrice = value;
  }

  set voivodeship(String value) {
    _voivodeship = value;
  }

  void clearLocation() {
    _voivodeship = null;
    _city = null;
  }

  Map<String, dynamic> toDto() {
    return {
      'dealType': DealTypeHelper.asString(_dealType),
      'title': _title,
      'link': _urlLocation,
      'description': _description,
      'locationDescription': _locationDescription,
      'categoriesIds': _categories.map((e) => e.id).toList(),
      'ageTypes': _ageTypes.map((e) => e.index).toList(),
      'locationType': _locationType.index,
      'city': _city,
      'voivodeship': _voivodeship,
      'startDate': _validFrom.toIso8601String(),
      'endDate': _validTo.toIso8601String(),
      'code': _dealCode,
      'currentPrice': _currentPrice,
      'regularPrice': _regularPrice,
      'shippingPrice': _shippingPrice,
    };
  }

  @override
  String toString() {
    return 'AddDealModel{_title: $_title, _urlLocation: $_urlLocation, _description: $_description, _categories: $_categories, _ageType: $_ageTypes, _locationType: $_locationType, _city: $_city, _validFrom: $_validFrom, _validTo: $_validTo, _dealCode: $_dealCode, _discountValue: $_discountValue, _regularPrice: $_regularPrice, _currentPrice: $_currentPrice, _shippingPrice: $_shippingPrice}';
  }
}