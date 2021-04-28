import 'dart:convert';

import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/models/location_type.dart';
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
  final LocationType locationType;
  final String voivodeship;
  final String city;
  final String locationDescription;
  final double currentPrice;
  final double regularPrice;
  final double shippingPrice;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfComments;
  final int numberOfPositiveVotes;
  final int numberOfNegativeVotes;
  final List<String> positiveVoters;
  final List<String> negativeVoters;
  final Image image;

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
    @required this.numberOfPositiveVotes,
    @required this.numberOfNegativeVotes,
    @required this.positiveVoters,
    @required this.negativeVoters,
    @required this.image,
  });

  static DealModel fromJson(dynamic dealSnapshot) {
    if (dealSnapshot == null) {
      return null;
    }
    return DealModel(
      id: dealSnapshot['id'],
      addedAt: DateTime.parse(dealSnapshot['addedAt']),
      addedById: dealSnapshot['addedById'],
      addedByUsername: dealSnapshot['addedByUsername'],
      addedByAvatarPath: dealSnapshot['addedByAvatarPath'],
      title: dealSnapshot['title'],
      description: dealSnapshot['description'],
      link: dealSnapshot['link'],
      dealType: DealTypeHelper.of(dealSnapshot['dealType']),
      categories: [
        ...(dealSnapshot['categories'] as List).map((e) => e['name']).toList()
      ],
      locationType: LocationTypeHelper.fromString(dealSnapshot['locationType']),
      voivodeship: dealSnapshot['voivodeship'],
      city: dealSnapshot['city'],
      locationDescription: dealSnapshot['locationDescription'],
      currentPrice: dealSnapshot['currentPrice'],
      regularPrice: dealSnapshot['regularPrice'],
      shippingPrice: dealSnapshot['shippingPrice'],
      startDate: DateTime.parse(dealSnapshot['startDate']),
      endDate: DateTime.parse(dealSnapshot['endDate']),
      numberOfComments: dealSnapshot['numberOfComments'],
      numberOfPositiveVotes: dealSnapshot['numberOfPositiveVotes'],
      numberOfNegativeVotes: dealSnapshot['numberOfNegativeVotes'],
      positiveVoters: [...dealSnapshot['positiveVoters'] as List],
      negativeVoters: [...dealSnapshot['negativeVoters'] as List],
      image: _getImage(dealSnapshot),
      // image: null,
    );
  }

  String get discountString {
    if (dealType == DealType.OCCASION) {
      return '${((regularPrice - currentPrice) / regularPrice * 100).toStringAsFixed(0)}% taniej';
    } else {
      return 'kupon';
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
        return 'brak';
      }
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

  static _getImage(dealObject) {
    var base64Image = base64Decode(dealObject['base64Image']);
    if (base64Image.isEmpty) {
      return null;
    }
    // var image = File('test.png');
    // return image.writeAsBytesSync(base64Image);
    return Image.memory(base64Image);
  }
}
