import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CurrentUser with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  UserModel _me;
  String _userId;
  String _token;
  List<DealModel> _observedDeals = [];
  List<DealModel> _addedDeals = [];

  CurrentUser.empty();

  bool get isAuthenticated {
    return _token != null;
  }

  UserModel get me {
    return _me;
  }

  List<DealModel> get observedDeals {
    return [..._observedDeals];
  }

  List<DealModel> get addedDeals {
    return [..._addedDeals];
  }

  Future<void> fetchMe() async {
    final responseBody = await _apiProvider.get('/users/me', token: _token);
    _me = UserModel.fromJson(responseBody);
  }

  Future<void> fetchObservedDeals() async {
    final responseBody =
    await _apiProvider.get('/users/me/deals/observed', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _observedDeals = DealModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchAddedDeals() async {
    final responseBody = await _apiProvider.get('/users/me/deals/added', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _addedDeals = DealModel.fromJsonList(responseBody);
    notifyListeners();
  }

  void update(String token, String userId) async {
    _token = token;
    _userId = userId;
    if (!isAuthenticated) {
      _addedDeals = [];
      _observedDeals = [];
    }
    await fetchMe();
    notifyListeners();
  }
}
