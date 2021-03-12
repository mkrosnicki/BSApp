import 'dart:convert';

import 'package:BSApp/mappers/deal_mapper.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

enum DealType {
  COUPON,
  OCCASION,
}

class Deals with ChangeNotifier {
  ApiProvider _apiProvider = ApiProvider();
  List<DealModel> _deals = [];

  List<DealModel> get deals {
    return [..._deals];
  }

  Future<void> fetchDeals() async {
    print('fetching deals!');
    _apiProvider.get('/deals');
    final List<DealModel> loadedDeals = [];
    final responseBody = await _apiProvider.get('/deals') as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    print(responseBody);
    responseBody.forEach((element) {
      loadedDeals.add(DealMapper.of(element));
      print(DealMapper.of(element));
    });
    _deals = loadedDeals;
    notifyListeners();
  }

  findById(String dealId) {
    return _deals.firstWhere((deal) => deal.id == dealId);
  }
}
