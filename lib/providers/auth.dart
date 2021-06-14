import 'dart:async';
import 'dart:convert';

import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
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

  Future<void> login(String email, String password) async {
    final responseData = await _apiProvider.post('/auth/login', {
      'email': email,
      'password': password,
    });
    _handleAuthenticationResponse(responseData);
    await fetchMe();
    notifyListeners();
    _scheduleAutoLogout();
    _saveAuthCookie();
    // _connectToNotificationsSocket(_userId);
  }

  Future<void> loginFB() async {
    final FacebookLogin fbLogin = FacebookLogin();
    final FacebookLoginResult result = await fbLogin.logIn(["email"]);
    final String token = result.accessToken.token;

    final response = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
    final profile = json.decode(response.body);
    print(profile);

    final responseData = await _apiProvider.post('/auth/login-fb', {'email': profile['email'], 'userId': profile['id'], 'inputToken': token});
    _handleAuthenticationResponse(responseData);
    await fetchMe();
    notifyListeners();
    _scheduleAutoLogout();
    _saveAuthCookie();
    // _connectToNotificationsSocket(_userId);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authData')) {
      return false;
    }
    final extractedUserData =
    json.decode(prefs.getString('authData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    await fetchMe();
    notifyListeners();
    _scheduleAutoLogout();
    // _connectToNotificationsSocket(_userId);
    return true;
  }

  Future<void> signUp(String email, String password, String username) async {
    await _apiProvider.post('/auth/signup', {
      'email': email,
      'password': password,
      'username': username,
    });
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
    // _disconnectFromNotificationsSocket(_userId);
    notifyListeners();
    _removeAuthCookie();
  }

  Future<void> deleteAccount() async {
    await _apiProvider.delete('/users/me', token: _token);
    return logout();
  }

  Future<void> resendVerificationToken(String email) async {
    await _apiProvider.get('/resend-token', requestParams: {
      'email': email,
    });
  }

  Future<void> resetUserPassword(String email) async {
    await _apiProvider.get('/auth/reset-password', requestParams: {
      'email': email,
    });
  }

  Future<void> changeUserPassword(String currentPassword, String newPassword) async {
    await _apiProvider.post('/auth/change-password', {
      'userId': _userId,
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    },
        token: _token);
  }

  Future<void> fetchMe() async {
    final responseBody = await _apiProvider.get('/users/me', token: _token);
    _me = UserModel.fromJson(responseBody);
  }

  Future<void> updateMe() async {
    final responseBody = await _apiProvider.patch(
        '/users/me/', {'notificationsSeenAtUpdate': true},
        token: _token);
    if (responseBody == null) {
      print('No User Found!');
    }
    _me = UserModel.fromJson(responseBody);
    notifyListeners();
  }

  void _handleAuthenticationResponse(dynamic authenticationResponse) {
    _token = authenticationResponse['token'] as String;
    final decoded = _decodeToken(_token);
    _userId = _extractUserId(decoded);
    _expiryDate = _extractExpiryDate(decoded);
  }

  Future<void> _saveAuthCookie() async {
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

  Future<void> _removeAuthCookie() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('authData');
  }

  void _scheduleAutoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate
        .difference(DateTime.now())
        .inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Map<String, dynamic> _decodeToken(String token) {
    final parts = token.split('.');
    final payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String decodedStr = utf8.decode(base64Url.decode(normalized));
    return json.decode(decodedStr) as Map<String, dynamic>;
  }

  String _extractUserId(Map<String, dynamic> decoded) {
    return decoded['sub'] as String;
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
  // public static readonly OAUTH2_REDIRECT_URI = 'http://localhost:4200/oauth2/redirect'
  //
  // public static readonly GOOGLE_AUTH_URL = ApiProvider.domain + '/oauth2/authorize/google?redirect_uri=' + EndpointsUrls.OAUTH2_REDIRECT_URI;
  // public static readonly FACEBOOK_AUTH_URL = ApiProvider.domain + '/oauth2/authorize/facebook?redirect_uri=' + EndpointsUrls.OAUTH2_REDIRECT_URI;}
