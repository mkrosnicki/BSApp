
import 'package:BSApp/mappers/deal_mapper.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

enum DealType {
  COUPON,
  OCCASION,
}

class Deals with ChangeNotifier {

  ApiProvider _apiProvider = new ApiProvider();

  List<DealModel> allDeals = [];
  List<DealModel> fetchedObservedDeals = [];
  List<DealModel> fetchedAddedDeals = [];
  String token;

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
    print(requestParams);
    final responseBody = await _apiProvider.get('/deals', requestParams: requestParams) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      loadedDeals.add(DealMapper.of(element));
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
      fetchedDeals.add(DealMapper.of(element));
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
      fetchedDeals.add(DealMapper.of(element));
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

  findById(String dealId) {
    return allDeals.firstWhere((deal) => deal.id == dealId);
  }

  isObservedDeal(DealModel deal) {
    return fetchedObservedDeals.contains(deal);
  }
}
