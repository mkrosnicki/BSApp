import 'dart:convert';

import 'package:BSApp/mappers/deal_mapper.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum DealType {
  COUPON,
  OCCASION,
}

class Deals with ChangeNotifier {
  List<DealModel> _deals = [];

  List<DealModel> get deals {
    return [..._deals];
  }

  Future<void> fetchDeals() async {
    print('fetching deals!');
    // final url = 'http://192.168.1.139:8080/deals';
    final url = 'http://192.168.162.241:8080/deals';
    final response = await http.get(url);
    print(response);
    final List<DealModel> loadedDeals = [];
    final responseBody = json.decode(response.body) as List;
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
