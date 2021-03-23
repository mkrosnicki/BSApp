import 'package:BSApp/models/deal_type.dart';
import 'package:flutter/material.dart';

class DealModel {
  final String id;
  final DateTime addedAt;
  final String addedById;
  final String addedByUsername;
  final String addedByAvatarPath;
  final String title;
  final String description;
  final String link;
  final DealType dealType;
  final List<String> categories;
  final String locationType;
  final String voivodeship;
  final String city;
  final String locationDescription;
  final double currentPrice;
  final double regularPrice;
  final double shippingPrice;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfComments;
  final int points;

  DealModel({
    @required this.id,
    @required this.addedAt,
    @required this.addedById,
    @required this.addedByUsername,
    @required this.addedByAvatarPath,
    @required this.title,
    @required this.description,
    @required this.link,
    @required this.dealType,
    @required this.categories,
    @required this.locationType,
    @required this.voivodeship,
    @required this.city,
    @required this.locationDescription,
    @required this.currentPrice,
    @required this.regularPrice,
    @required this.shippingPrice,
    @required this.startDate,
    @required this.endDate,
    @required this.numberOfComments,
    @required this.points,
  });

  static DealModel of(dynamic dealObject) {
    return DealModel(
        id: dealObject['id'],
        addedAt: DateTime.parse(dealObject['addedAt']),
        addedById: dealObject['addedById'],
        addedByUsername: dealObject['addedByUsername'],
        addedByAvatarPath: dealObject['addedByAvatarPath'],
        title: dealObject['title'],
        description: dealObject['description'],
        link: dealObject['link'],
        dealType: DealTypeHelper.of(dealObject['dealType']),
        categories: [...(dealObject['categories'] as List).map((e) => e['name']).toList()],
        locationType: dealObject['locationType'],
        voivodeship: dealObject['voivodeship'],
        city: dealObject['city'],
        locationDescription: dealObject['locationDescription'],
        currentPrice: dealObject['currentPrice'],
        regularPrice: dealObject['regularPrice'],
        shippingPrice: dealObject['shippingPrice'],
        startDate: DateTime.parse(dealObject['startDate']),
        endDate: DateTime.parse(dealObject['endDate']),
        numberOfComments: dealObject['numberOfComments'],
        points: dealObject['points']);
  }


  String get discountString {
    if (dealType == DealType.OCCASION) {
      return '${((regularPrice - currentPrice) / regularPrice * 100).toStringAsFixed(0)}% taniej';
    } else {
      return 'kupon';
    }
  }

  @override
  String toString() {
    return 'DealModel{id: $id, title: $title, dealType: $dealType}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DealModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}