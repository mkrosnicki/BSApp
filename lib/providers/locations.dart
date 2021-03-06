import 'package:BSApp/models/voivodeship_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Locations with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<Voivodeship> _voivodeships = [];

  List<Voivodeship> get voivodeships {
    return [..._voivodeships];
  }

  Future<void> fetchVoivodeships() async {
    if (_voivodeships.isEmpty) {
      final List<Voivodeship> loadedVoivodeships = [];
      final responseBody = await _apiProvider.get('/voivodeships') as List;
      if (responseBody == null) {
        final logger = Logger();
        logger.e('No Voivodeships Found!');
      }
      responseBody.forEach((element) {
        loadedVoivodeships.add(Voivodeship.fromJson(element));
      });
      _voivodeships = loadedVoivodeships;
      notifyListeners();
    }
  }
}
