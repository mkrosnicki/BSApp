import 'dart:async';
import 'dart:convert';

import 'package:BSApp/models/http_exception.dart';
import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  UserModel _me;

  bool get isAuthenticated {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return _token;
  }

  String get userId {
    return _userId;
  }

  UserModel get me {
    return _me;
  }

  Future<void> fetchMe() async {
    var responseBody = await _apiProvider.get('/users/me', token: _token);
    _me = UserModel.of(responseBody);
  }

  Future<void> login(String email, String password) async {
    final url = '/auth/login';
    var body = {
          'email': email,
          'password': password,
        };
    final responseData = await _apiProvider.post(url, body);
    _token = responseData['token'];
    await fetchMe();
    var decoded = _decodeToken(_token);
    _userId = _extractUserId(decoded);
    _expiryDate = _extractExpiryDate(decoded);
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode(
      {
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
      },
    );
    prefs.setString('authData', userData);
  }

  Future<void> signup(String email, String password, String username) async {
    final url = '/auth/signup';
    var body = {
      'email': email,
      'password': password,
      'username': username,
    };
    await _apiProvider.post(url, body);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('authData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    await fetchMe();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _me = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('authData');
    prefs.clear();
  }

  Future<void> deleteAccount() async {
    await _apiProvider.delete('/users/me', token: _token);
    return logout();
  }

  Future<void> resendVerificationToken(String email) async {
    var queryParameters = {
      'email': email,
    };
    await _apiProvider.get('/resend-token', requestParams: queryParameters);
  }

  Future<void> resetUserPassword(String email) async {
    var queryParameters = {
      'email': email,
    };
    await _apiProvider.get('/auth/reset-password', requestParams: queryParameters);
  }

  Future<void> changeUserPassword(String currentPassword, String newPassword) async {
    var url = '/auth/change-password';
    var body = {
      'userId': _userId,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    };
    await _apiProvider.post(url, body);
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Map<String, dynamic> _decodeToken(String token) {
    final parts = token.split('.');
    final payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String decodedStr = utf8.decode(base64Url.decode(normalized));
    return json.decode(decodedStr);
  }

  String _extractUserId(Map<String, dynamic> decoded) {
    return decoded['sub'];
  }

  int _extractExpiresInMs(Map<String, dynamic> decoded) {
    final int expiresIn = decoded['exp'];
    final int issuedAt = decoded['iat'];
    return (expiresIn - issuedAt) * 1000;
  }

  DateTime _parseToExpiryDate(int expiresInMs) {
    return DateTime.now().add(Duration(milliseconds: expiresInMs));
  }

  DateTime _extractExpiryDate(Map<String, dynamic> decoded) {
    return _parseToExpiryDate(_extractExpiresInMs(decoded));
  }

}