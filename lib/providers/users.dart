import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  Map<String, UserModel> _idToUserMap = {};

  Future<void> fetchUser(String userId) async {
    final responseBody = await _apiProvider.get('/users/$userId') as Map;
    print(responseBody);
    if (responseBody == null) {
      print('No User Found!');
    }
    _idToUserMap.update(userId, (value) => UserModel.of(responseBody), ifAbsent: () => UserModel.of(responseBody));
  }

  Future<UserModel> findUser(String userId) async {
    await fetchUser(userId);
    return _idToUserMap[userId];
  }

  UserModel getUser(String userId) {
    return _idToUserMap[userId];
  }
}
