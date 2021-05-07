
import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Deals with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  List<DealModel> allDeals = [];

  String _token;

  Deals.empty();

  List<DealModel> get deals {
    return [...allDeals];
  }

  Future<void> fetchDeals({Map<String, dynamic> requestParams}) async {
    final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No Deals Found!');
    }
    allDeals = DealModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> voteForDeal(String dealId, bool isPositive) async {
    await _apiProvider.post('/deals/$dealId/votes', {'isPositive': isPositive}, token: _token);
    return fetchDeals();
  }

  Future<void> createNewDeal(AddDealModel newDeal) async {
    return _apiProvider.post('/deals', newDeal.toDto(), token: _token);
  }

  DealModel findById(String dealId) {
    return allDeals.firstWhere((deal) => deal.id == dealId);
  }

  bool wasVotedPositivelyBy(String dealId, String userId) {
    return findById(dealId).positiveVoters.any((element) => element == userId);
  }

  bool wasVotedNegativelyBy(String dealId, String userId) {
    return findById(dealId).negativeVoters.any((element) => element == userId);
  }

  void update(String token) {
    _token = token;
  }
}
