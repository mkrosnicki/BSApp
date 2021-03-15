
import 'package:BSApp/mappers/deal_mapper.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

enum DealType {
  COUPON,
  OCCASION,
}

class Deals with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  List<DealModel> _deals = [];
  List<DealModel> _favouriteDeals = [];

  List<DealModel> get deals {
    return [..._deals];
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
    _deals = loadedDeals;
    notifyListeners();
  }

  Future<void> fetchFavouriteDeals() async {
    final List<DealModel> favouriteDeals = [];
    final responseBody =
        await _apiProvider.get('/users/me/observed') as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      favouriteDeals.add(DealMapper.of(element));
    });
    _favouriteDeals = favouriteDeals;
    notifyListeners();
  }

  Future<void> addToFavouriteDeals(String dealId) async {
    final addDealToFavouritesDto = {'dealId': dealId};
    await _apiProvider.post('/users/me/observed', addDealToFavouritesDto);
    return fetchFavouriteDeals();
  }

  findById(String dealId) {
    return _deals.firstWhere((deal) => deal.id == dealId);
  }

  isFavouriteDeal(DealModel deal) {
    return _favouriteDeals.contains(deal);
  }
}
