import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DealModel {
  String id;
  String title;

  DealModel({@required this.id, @required this.title});

  @override
  String toString() {
    return 'DealModel{id: $id, title: $title}';
  }
}

class Deals with ChangeNotifier {
  List<DealModel> _deals = [];

  List<DealModel> get deals {
    return [..._deals];
  }

  Future<void> fetchDeals() async {
    print('fetching deals!');
    final url = 'http://192.168.162.241:8080/deals';
    final response = await http.get(url);
    print(response);
    final List<DealModel> loadedDeals = [];
    final responseBody = json.decode(response.body) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      loadedDeals.add(DealModel(
        id: element['id'],
        title: element['title'],
      ));
      print(DealModel(
        id: element['id'],
        title: element['title'],
      ));
    });
    _deals = loadedDeals;
    notifyListeners();
  }
}
