import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Locations with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  List<Voivodeship> _voivodeships = [];

  List<Voivodeship> get voivodeships {
    return [..._voivodeships];
  }

  Future<void> fetchVoivodeships() async {
    final List<Voivodeship> loadedVoivodeships = [];
    final responseBody = await _apiProvider.get('/voivodeships') as List;
    if (responseBody == null) {
      print('No Voivodeships Found!');
    }
    responseBody.forEach((element) {
      loadedVoivodeships.add(Voivodeship.of(element));
    });
    _voivodeships = loadedVoivodeships;
    notifyListeners();
  }

}