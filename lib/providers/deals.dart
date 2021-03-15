
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
  List<DealModel> favouriteDeals = [];
  String token;

  Deals({this.allDeals, this.favouriteDeals, this.token});


  List<DealModel> get deals {
    return [...allDeals];
  }

  Future<void> fetchDeals() async {
    final List<DealModel> loadedDeals = [];
    final responseBody = await _apiProvider.get('/deals') as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      loadedDeals.add(DealMapper.of(element));
      print(DealMapper.of(element));
    });
    allDeals = loadedDeals;
    notifyListeners();
  }

  Future<void> fetchFavouriteDeals() async {
    final List<DealModel> fetchedDeals = [];
    final responseBody =
        await _apiProvider.get('/users/me/observed', token: token) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    print(responseBody);
    responseBody.forEach((element) {
      fetchedDeals.add(DealMapper.of(element));
    });
    favouriteDeals = fetchedDeals;
    print(fetchedDeals);
    notifyListeners();
  }

  Future<void> addToFavouriteDeals(String dealId) async {
    final addDealToFavouritesDto = {'dealId': dealId};
    await _apiProvider.post('/users/me/observed', addDealToFavouritesDto, token: token);
    return fetchFavouriteDeals();
  }

  Future<void> deleteFromFavouriteDeals(String dealId) async {
    await _apiProvider.delete('/users/me/observed/$dealId', token: token);
    return fetchFavouriteDeals();
  }

  findById(String dealId) {
    return allDeals.firstWhere((deal) => deal.id == dealId);
  }

  isFavouriteDeal(DealModel deal) {
    return favouriteDeals.contains(deal);
  }
}
