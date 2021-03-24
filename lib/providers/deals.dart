
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Deals with ChangeNotifier {

  ApiProvider _apiProvider = new ApiProvider();

  List<DealModel> allDeals = [];
  List<DealModel> fetchedObservedDeals = [];
  List<DealModel> fetchedAddedDeals = [];
  String token;

  Deals.empty();

  Deals({this.allDeals, this.fetchedObservedDeals, this.token});


  List<DealModel> get deals {
    return [...allDeals];
  }

  List<DealModel> get observedDeals {
    return [...fetchedObservedDeals];
  }

  List<DealModel> get addedDeals {
    return [...fetchedAddedDeals];
  }

  Future<void> fetchDeals({Map<String, dynamic> requestParams}) async {
    final List<DealModel> loadedDeals = [];
    final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      loadedDeals.add(DealModel.of(element));
    });
    allDeals = loadedDeals;
    notifyListeners();
  }

  Future<void> fetchObservedDeals() async {
    final List<DealModel> fetchedDeals = [];
    final responseBody =
        await _apiProvider.get('/users/me/observed', token: token) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedDeals.add(DealModel.of(element));
    });
    fetchedObservedDeals = fetchedDeals;
    notifyListeners();
  }

  Future<void> fetchAddedDeals() async {
    final List<DealModel> fetchedDeals = [];
    final responseBody =
    await _apiProvider.get('/users/me/deals/added', token: token) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedDeals.add(DealModel.of(element));
    });
    fetchedAddedDeals = fetchedDeals;
    notifyListeners();
  }

  Future<void> addToObservedDeals(String dealId) async {
    final addDealToFavouritesDto = {'dealId': dealId};
    await _apiProvider.post('/users/me/observed', addDealToFavouritesDto, token: token);
    return fetchObservedDeals();
  }

  Future<void> deleteFromObservedDeals(String dealId) async {
    await _apiProvider.delete('/users/me/observed/$dealId', token: token);
    return fetchObservedDeals();
  }

  Future<void> voteForPlus(String dealId) async {
    return _addVoteToDeal(dealId, true);
  }

  Future<void> voteForMinus(String dealId) async {
    return _addVoteToDeal(dealId, false);
  }

  Future<void> _addVoteToDeal(String dealId, bool isPositive) async {
    await _apiProvider.post('/deals/$dealId/votes', {'isPositive': isPositive}, token: token);
    return fetchDeals();
  }

  findById(String dealId) {
    return allDeals.firstWhere((deal) => deal.id == dealId);
  }

  bool isObservedDeal(DealModel deal) {
    return fetchedObservedDeals.contains(deal);
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
