
import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/adder_info_model.dart';
import 'package:BSApp/models/deal_details_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Deals with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  int _totalPages = 0;
  int _totalElements = 0;

  List<DealModel> _deals = [];

  String _token;

  Deals.empty();

  List<DealModel> get deals {
    return [..._deals];
  }

  Future<void> fetchDeals({Map<String, dynamic> requestParams}) async {
    final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as Map;
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No Deals Found!');
    }
    _deals = DealModel.fromJsonList(responseBody['content'] as List);
    notifyListeners();
  }

  Future<AdderInfoModel> fetchAdderInfo(final String dealId) async {
    final responseBody = await _apiProvider.get('/deals/$dealId/adder');
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No Adder Found!');
    }
    return AdderInfoModel.fromJson(responseBody);
  }

  Future<void> fetchDealsPaged({int pageNo = 0, int pageSize = 7, Map<String, dynamic> requestParams}) async {
    if (canLoadPage(pageNo)) {
      requestParams ??= {};
      requestParams.putIfAbsent('pageNo', () => pageNo.toString());
      requestParams.putIfAbsent('pageSize', () => pageSize.toString());
      final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as Map;
      if (responseBody == null) {
        final logger = Logger();
        logger.e('No Deals Found!');
      }
      _handlePagedResponse(responseBody, pageNo);
      notifyListeners();
    }
  }

  void _handlePagedResponse(final Map<dynamic, dynamic> responseBody, final int pageNo) {
    _totalPages = responseBody['totalPages'] as int;
    _totalElements = responseBody['totalElements'] as int;
    final responseContent = responseBody['content'] as List;
    final List<DealModel> fetchedDeals = DealModel.fromJsonList(responseContent);
    _addPaged(fetchedDeals, pageNo);
  }

  void _addPaged(List<DealModel> fetchedDeals, int pageNo) {
    if (pageNo == 0) {
      _deals = fetchedDeals;
    } else {
      for (final DealModel deal in fetchedDeals) {
        if (!_deals.contains(deal)) {
          _deals.add(deal);
        }
      }
    }
  }

  bool canLoadPage(int pageNo) {
    return _totalPages >= pageNo;
  }

  Future<void> fetchMyObservedDeals() async {
    final responseBody = await _apiProvider.get('/users/me/deals/observed', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _deals = DealModel.fromJsonList(responseBody);
  }

  Future<void> fetchDealsAddedBy(String userId) async {
    final responseBody = await _apiProvider.get('/users/$userId/deals/added') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _deals = DealModel.fromJsonList(responseBody);
  }

  Future<void> fetchMyAddedDeals() async {
    final responseBody = await _apiProvider.get('/users/me/deals/added', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    _deals = DealModel.fromJsonList(responseBody);
  }

  Future<void> fetchDeal(String dealId) async {
    final responseBody =
    await _apiProvider.get('/deals/$dealId');
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deal Found!');
    } else {
      _deals.clear();
      _deals.add(DealModel.fromJson(responseBody));
    }
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

  Future<void> deleteDeal(String dealId) async {
    await _apiProvider.delete('/deals/$dealId', token: _token);
    _deals.removeWhere((deal) => deal.id == dealId);
    notifyListeners();
  }

  DealModel findById(String dealId) {
    return _deals.firstWhere((deal) => deal.id == dealId);
  }

  void update(String token, List<DealModel> deals) {
    _deals = deals;
    _token = token;
  }
}
