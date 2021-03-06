import 'dart:convert';

import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/discount_type.dart';
import 'package:BSApp/models/location_type.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class DealModel {
  final String id;
  final DateTime addedAt;
  final String title;
  final String description;
  final String link;
  final String code;
  final DealType dealType;
  final String category;
  final LocationType locationType;
  final String voivodeship;
  final String city;
  final String locationDescription;
  final double currentPrice;
  final double regularPrice;
  final double shippingPrice;
  final DiscountType discountType;
  final double discountValue;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> positiveVoters;
  final List<String> negativeVoters;
  final Image image;
  final String imagePath;

  DealModel({
    @required this.id,
    @required this.addedAt,
    @required this.title,
    @required this.description,
    @required this.link,
    @required this.code,
    @required this.dealType,
    @required this.category,
    @required this.locationType,
    @required this.voivodeship,
    @required this.city,
    @required this.locationDescription,
    @required this.currentPrice,
    @required this.regularPrice,
    @required this.shippingPrice,
    @required this.discountType,
    @required this.discountValue,
    @required this.startDate,
    @required this.endDate,
    @required this.positiveVoters,
    @required this.negativeVoters,
    @required this.image,
    @required this.imagePath,
  });

  static List<DealModel> fromJsonList(List<dynamic> dealsSnapshot) {
    final List<DealModel> deals = [];
    for (final dealSnapshot in dealsSnapshot) {
      deals.add(fromJson(dealSnapshot));
    }
    return deals;
  }

  static DealModel fromJson(dynamic dealSnapshot) {
    if (dealSnapshot == null) {
      return null;
    }
    return DealModel(
      id: dealSnapshot['id'],
      addedAt: DateUtil.parseFromStringToUtc(dealSnapshot['addedAt']),
      title: dealSnapshot['title'],
      description: dealSnapshot['description'],
      link: dealSnapshot['link'],
      code: dealSnapshot['code'],
      dealType: DealTypeHelper.of(dealSnapshot['dealType']),
      category: dealSnapshot['category']['name'],
      locationType: LocationTypeHelper.fromString(dealSnapshot['locationType']),
      voivodeship: dealSnapshot['voivodeship'],
      city: dealSnapshot['city'],
      locationDescription: dealSnapshot['locationDescription'],
      currentPrice: dealSnapshot['currentPrice'],
      regularPrice: dealSnapshot['regularPrice'],
      shippingPrice: dealSnapshot['shippingPrice'],
      discountType: DiscountTypeHelper.fromString(dealSnapshot['discountType']),
      discountValue: dealSnapshot['discountValue'],
      startDate: dealSnapshot['startDate'] == null ? null : DateUtil.parseFromStringToUtc(dealSnapshot['startDate']),
      endDate: dealSnapshot['endDate'] == null ? null : DateUtil.parseFromStringToUtc(dealSnapshot['endDate']),
      positiveVoters: [...dealSnapshot['positiveVoters'] as List],
      negativeVoters: [...dealSnapshot['negativeVoters'] as List],
      image: _getImage(dealSnapshot),
      imagePath: dealSnapshot['imagePath'] != null ? dealSnapshot['imagePath'] : null,
      // image: null,
    );
  }

  bool hasPositiveVoteFrom(String userId) {
    return positiveVoters.any((element) => element == userId);
  }

  bool hasNegativeVoteFrom(String userId) {
    return negativeVoters.any((element) => element == userId);
  }

  String get priceString {
    if (dealType == DealType.OCCASION) {
     return '${currentPrice.toStringAsFixed(2)} z??';
    } else {
      return '-$discountValue${DiscountTypeHelper.getReadable(discountType)}';
    }
  }

  String get discountString {
    if (dealType == DealType.OCCASION) {
      return '${((regularPrice - currentPrice) / regularPrice * 100).toStringAsFixed(0)}% taniej';
    } else {
      return '$discountValue ${DiscountTypeHelper.getReadable(discountType)} taniej';
    }
  }

  String get locationString {
    if (locationType == LocationType.INTERNET) {
      return 'Internet';
    } else {
      if (city != null) {
        return city;
      } else if (voivodeship != null) {
        return voivodeship;
      } else {
        return 'Ca??a Polska';
      }
    }
  }

  bool get isExpired {
    return endDate != null && DateTime.now().isAfter(endDate);
  }


  @override
  String toString() {
    return 'DealModel{id: $id, title: $title, dealType: $dealType, categories: $category}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  static _getImage(dealObject) {
    final encodedImage = base64Decode(dealObject['encodedImage']);
    if (encodedImage.isEmpty) {
      return null;
    }
    // var image = File('test.png');
    // return image.writeAsBytesSync(encodedImage);
    return Image.memory(encodedImage, fit: BoxFit.cover,);
  }
}
