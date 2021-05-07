
import 'package:BSApp/models/add_deal_model.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Deals with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  List<DealModel> allDeals = [];
  List<DealModel> fetchedObservedDeals = [];
  List<DealModel> fetchedAddedDeals = [];
  List<DealModel> fetchedUserAddedDeals = [];

  String token;

  Deals({this.allDeals, this.fetchedObservedDeals, this.token});

  Deals.empty();


  List<DealModel> get deals {
    return [...allDeals];
  }

  List<DealModel> get observedDeals {
    return [...fetchedObservedDeals];
  }

  List<DealModel> get addedDeals {
    return [...fetchedAddedDeals];
  }

  List<DealModel> get userAddedDeals {
    return [...fetchedUserAddedDeals];
  }

  Future<void> fetchDeals({Map<String, dynamic> requestParams}) async {
    final List<DealModel> loadedDeals = [];
    final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No Deals Found!');
    }
    responseBody.forEach((element) {
      loadedDeals.add(DealModel.fromJson(element));
    });
    allDeals = loadedDeals;
    notifyListeners();
  }

  Future<void> fetchObservedDeals() async {
    final List<DealModel> fetchedDeals = [];
    final responseBody =
        await _apiProvider.get('/users/me/deals/observed', token: token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedDeals.add(DealModel.fromJson(element));
    });
    fetchedObservedDeals = fetchedDeals;
    notifyListeners();
  }

  Future<void> fetchAddedDeals() async {
    final List<DealModel> fetchedDeals = [];
    final responseBody =
    await _apiProvider.get('/users/me/deals/added', token: token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedDeals.add(DealModel.fromJson(element));
    });
    fetchedAddedDeals = fetchedDeals;
    notifyListeners();
  }

  Future<void> fetchDealsAddedBy(String userId) async {
    final List<DealModel> fetchedDeals = [];
    final responseBody =
    await _apiProvider.get('/users/$userId/addedDeals') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedDeals.add(DealModel.fromJson(element));
    });
    fetchedUserAddedDeals = fetchedDeals;
    notifyListeners();
  }

  Future<void> addToObservedDeals(String dealId) async {
    final addDealToFavouritesDto = {'dealId': dealId};
    await _apiProvider.post('/users/me/deals/observed', addDealToFavouritesDto, token: token);
    return fetchObservedDeals();
  }

  Future<void> removeFromObservedDeals(String dealId) async {
    await _apiProvider.delete('/users/me/deals/observed/$dealId', token: token);
    return fetchObservedDeals();
  }

  Future<void> voteForDeal(String dealId, bool isPositive) async {
    await _apiProvider.post('/deals/$dealId/votes', {'isPositive': isPositive}, token: token);
    return fetchDeals();
  }

  Future<void> createNewDeal(AddDealModel newDeal) async {
    return _apiProvider.post('/deals', newDeal.toDto(), token: token);
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

  bool isObservedDeal(DealModel deal) {
    return fetchedObservedDeals.contains(deal);
  }

  bool isObservedDealById(String dealId) {
    return fetchedObservedDeals.any((deal) => deal.id == dealId);
  }

  void update(String token) async {
    this.token = token;
    if (token == null) {
      fetchedObservedDeals = [];
      fetchedAddedDeals = [];
    } else {
      await fetchAddedDeals();
      await fetchObservedDeals();
    }
  }
}
