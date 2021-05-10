
import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Deals with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  List<DealModel> _deals = [];
  List<DealModel> _observedDeals = [];

  String _token;

  Deals.empty();

  List<DealModel> get deals {
    print('deals!!!!!!!!!!!!!!!!!!');
    return [..._deals];
  }

  Future<void> fetchDeals({Map<String, dynamic> requestParams}) async {
    final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No Deals Found!');
    }
    _deals = DealModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchMyObservedDeals() async {
    if (_token != null) {
      _deals = _observedDeals;
    } else {
      _deals = [];
    }
  }

  Future<void> fetchMyAddedDeals() async {
    final responseBody = await _apiProvider.get('/users/me/deals/added', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _deals = DealModel.fromJsonList(responseBody);
  }

  Future<void> voteForDeal(String dealId, bool isPositive) async {
    final responseBody = await _apiProvider.post('/deals/$dealId/votes', {'isPositive': isPositive}, token: _token);
    final DealModel votedDeal = DealModel.fromJson(responseBody);
    _deals[_deals.indexWhere((element) => element.id == votedDeal.id)] = votedDeal;
    notifyListeners();
  }

  Future<void> createNewDeal(AddDealModel newDeal) async {
    return _apiProvider.post('/deals', newDeal.toDto(), token: _token);
  }

  DealModel findById(String dealId) {
    return _deals.firstWhere((deal) => deal.id == dealId);
  }

  void update(String token, List<DealModel> deals, List<DealModel> observedDeals) {
    _deals = deals;
    _token = token;
    _observedDeals = observedDeals;
  }
}
