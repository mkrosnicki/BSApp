import 'dart:typed_data';

import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';

import 'deals_users_info_model.dart';

class DealDetailsModel {
  final String id;
  final DealModel deal;
  final DealsUsersInfo adderInfo;

  DealDetailsModel({
    @required this.id,
    @required this.deal,
    @required this.adderInfo,
  });

  static DealDetailsModel fromJson(dynamic dealDetailsSnapshot) {
    if (dealDetailsSnapshot == null) {
      return null;
    }
    return DealDetailsModel(
      id: dealDetailsSnapshot['id'] as String,
      deal: DealModel.fromJson(dealDetailsSnapshot['deal']),
      adderInfo: DealsUsersInfo.fromJson(dealDetailsSnapshot['adderInfo']),
    );
  }

  String get adderName {
    return adderInfo != null ? adderInfo.username : 'Usunięty użytkownik';
  }

  Uint8List get userAvatar {
    return adderInfo != null ? adderInfo.avatar : null;
  }

  String get userImagePath {
    return adderInfo != null ? adderInfo.imagePath : null;
  }


  @override
  String toString() {
    return 'DealDetailsModel{id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DealDetailsModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}
