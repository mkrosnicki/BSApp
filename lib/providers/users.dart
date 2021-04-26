import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Users with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  Map<String, UserModel> _idToUserMap = {};
  Map<String, UsersProfileModel> _idToUsersProfileMap = {};

  Future<void> fetchUser(String userId) async {
    final responseBody = await _apiProvider.get('/users/$userId') as Map;
    if (responseBody == null) {
      print('No User Found!');
    }
    _idToUserMap.update(userId, (value) => UserModel.fromJson(responseBody), ifAbsent: () => UserModel.fromJson(responseBody));
  }

  Future<void> fetchUsersProfile(String userId) async {
    final responseBody = await _apiProvider.get('/users/$userId/profile') as Map;
    if (responseBody == null) {
      print('No Users Profile Found!');
    }
    _idToUsersProfileMap.update(userId, (value) => UsersProfileModel.fromJson(responseBody), ifAbsent: () => UsersProfileModel.fromJson(responseBody));
    print(UsersProfileModel.fromJson(responseBody).activities);
  }

  Future<UserModel> findUser(String userId) async {
    await fetchUser(userId);
    return _idToUserMap[userId];
  }

  Future<UsersProfileModel> findUsersProfile(String userId) async {
    await fetchUsersProfile(userId);
    return _idToUsersProfileMap[userId];
  }

  UserModel getUser(String userId) {
    return _idToUserMap[userId];
  }

  UsersProfileModel getUsersProfile(String userId) {
    return _idToUsersProfileMap[userId];
  }
}
