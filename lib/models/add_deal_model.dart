import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/location_type.dart';

import 'category_model.dart';

class AddDealModel {

  String _title;
  String _urlLocation;
  String _description;
  List<CategoryModel> _categories = [];
  AgeType _ageType;
  LocationType _locationType;
  String _city;
  DateTime _validFrom;
  DateTime _validTo;
  String _dealCode;
  double _discountValue;
  double _regularPrice;
  double _currentPrice;
  double _shippingPrice;
  String _voivodeship;


  List<CategoryModel> get categories => _categories;

  AgeType get ageType => _ageType;

  String get city => _city;

  LocationType get locationType => _locationType;

  String get voivodeship => _voivodeship;

  set title(String value) {
    _title = value;
  }

  set urlLocation(String value) {
    _urlLocation = value;
  }

  set description(String value) {
    _description = value;
  }

  set categories(List<CategoryModel> value) {
    _categories = value;
  }

  set ageType(AgeType value) {
    _ageType = value;
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

  @override
  String toString() {
    return 'AddDealModel{_title: $_title, _urlLocation: $_urlLocation, _description: $_description, _categories: $_categories, _ageType: $_ageType, _locationType: $_locationType, _city: $_city, _validFrom: $_validFrom, _validTo: $_validTo, _dealCode: $_dealCode, _discountValue: $_discountValue, _regularPrice: $_regularPrice, _currentPrice: $_currentPrice, _shippingPrice: $_shippingPrice}';
  }
}