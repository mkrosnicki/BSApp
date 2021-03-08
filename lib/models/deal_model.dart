import 'package:BSApp/providers/deals.dart';
import 'package:flutter/material.dart';

class DealModel {
  final String id;
  final String title;
  final String description;
  final String link;
  final DealType dealType;
  final String category;
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
    @required this.title,
    @required this.description,
    @required this.link,
    @required this.dealType,
    @required this.category,
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