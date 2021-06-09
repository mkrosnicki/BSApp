import 'dart:convert';
import 'dart:io';

import 'package:BSApp/models/age_type.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/discount_type.dart';
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
  String _voivodeshipReadable;
  String _city;
  String _cityReadable;
  DateTime _validFrom;
  DateTime _validTo;
  String _dealCode;
  DiscountType _discountType;
  double _discountValue;
  double _regularPrice;
  double _currentPrice;
  double _shippingPrice;
  File _image;
  String _imageUrl;

  DateTime get validFrom => _validFrom;

  String get title => _title;

  String get description => _description;

  String get urlLocation => _urlLocation;

  String get locationDescription => _locationDescription;

  DateTime get validTo => _validTo;

  List<CategoryModel> get categories => _categories;

  List<AgeType> get ageTypes => _ageTypes;

  String get city => _city;

  String get cityReadable => _cityReadable;

  LocationType get locationType => _locationType;

  String get voivodeship => _voivodeship;

  String get voivodeshipReadable => _voivodeshipReadable;

  DiscountType get discountType => _discountType;

  File get image => _image;

  String get imageUrl => _imageUrl;

  bool get isInternetType {
    return locationType == LocationType.INTERNET;
  }

  set image(File value) {
    _image = value;
  }

  set discountType(DiscountType value) {
    _discountType = value;
  }

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

  set ageTypes(List<AgeType> value) {
    _ageTypes = value;
  }

  set locationType(LocationType value) {
    _locationType = value;
  }

  set city(String value) {
    _city = value;
  }

  set cityReadable(String value) {
    _cityReadable = value;
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

  set voivodeshipReadable(String value) {
    _voivodeshipReadable = value;
  }

  set imageUrl(String value) {
    _imageUrl = value;
  }

  void clearLocation() {
    _voivodeship = null;
    _city = null;
    _locationDescription = null;
  }

  void reset() {
    _title = null;
    _urlLocation = null;
    _description = null;
    _locationDescription = null;
    _categories = [];
    _ageTypes = [];
    _voivodeship = null;
    _voivodeshipReadable = null;
    _city = null;
    _cityReadable = null;
    _validFrom = DateTime.now();
    _validTo = DateTime.now();
    _dealCode = null;
    _discountValue = null;
    _regularPrice = null;
    _currentPrice = null;
    _shippingPrice = null;
    _image = null;
    _imageUrl = null;
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
      'discountType': DiscountTypeHelper.asString(_discountType),
      'discountValue': _discountValue,
      'currentPrice': _currentPrice,
      'regularPrice': _regularPrice,
      'shippingPrice': _shippingPrice,
      'image': _image == null ? null : base64Encode(_image.readAsBytesSync()),
      'imageUrl': _imageUrl,
    };
  }

  @override
  String toString() {
    return 'AddDealModel{_title: $_title, _urlLocation: $_urlLocation, _description: $_description, _categories: $_categories, _ageType: $_ageTypes, _locationType: $_locationType, _city: $_city, _validFrom: $_validFrom, _validTo: $_validTo, _dealCode: $_dealCode, _discountValue: $_discountValue, _regularPrice: $_regularPrice, _currentPrice: $_currentPrice, _shippingPrice: $_shippingPrice, _imageUrl: $imageUrl}';
  }
}