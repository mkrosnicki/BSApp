import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Users with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  UserModel _user;
  UsersProfileModel _usersProfile;
  String _token;

  Users.empty();

  UserModel get user {
    return _user;
  }

  Future<void> fetchUser(String userId) async {
    final responseBody = await _apiProvider.get('/users/$userId') as Map;
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No User Found!');
    }
    _user = UserModel.fromJson(responseBody);
  }

  Future<void> fetchUsersProfile(String userId) async {
    final responseBody =
        await _apiProvider.get('/users/$userId/profile') as Map;
    if (responseBody == null) {
      final logger = Logger();
      logger.e('No User Profile Found!');
    }
    _usersProfile = UsersProfileModel.fromJson(responseBody);
  }

  Future<UserModel> findUser(String userId) async {
    await fetchUser(userId);
    return _user;
  }

  Future<UsersProfileModel> findUsersProfile(String userId) async {
    await fetchUsersProfile(userId);
    return _usersProfile;
  }

  UserModel getUser(String userId) {
    return _user;
  }

  UsersProfileModel getUsersProfile(String userId) {
    return _usersProfile;
  }


  Future<void> updateUser(String userId, DateTime bannedUntil) async {
    final responseBody = await _apiProvider.patch('/users/$userId/votes', {'bannedUntil': bannedUntil.toIso8601String}, token: _token);
    if (responseBody != null) {
      final UserModel updatedUser = UserModel.fromJson(responseBody);
      _user = updatedUser;
      notifyListeners();
    }
  }

  void update(String token, UserModel user) {
    _user = user;
    _token = token;
  }
}
