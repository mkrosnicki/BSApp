import 'dart:async';
import 'dart:convert';

import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp/stomp.dart';
import 'package:BSApp/services/custom_stomp' as customStomp;

class Auth with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();
  StompClient _client;
  DateTime _lastNotificationDate;
  List<NotificationModel> _notifications = [];
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

  DateTime get notificationsSeenAt {
    return _me != null ? _me.notificationsSeenAt : null;
  }

  DateTime get unreadNotificationsCount {
    return _lastNotificationDate;
  }

  bool get newNotificationsPresent {
    if (notificationsSeenAt != null && _lastNotificationDate != null) {
      return notificationsSeenAt.isBefore(_lastNotificationDate);
    }
    return false;
  }

  List<NotificationModel> get myNotifications {
    return [..._notifications];
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
    _connectToNotificationsSocket(_userId);
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
    await fetchMe();
    notifyListeners();
    _scheduleAutoLogout();
    _connectToNotificationsSocket(_userId);
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
    _disconnectFromNotificationsSocket(_userId);
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
    });
  }

  Future<void> fetchMe() async {
    final responseBody = await _apiProvider.get('/users/me', token: _token);
    _me = UserModel.fromJson(responseBody);
  }

  Future<void> updateNotificationsSeenAt() async {
    final responseBody = await _apiProvider.patch(
        '/users/me/',
        {'notificationsSeenAtUpdate': true},
        token: _token
    );
    if (responseBody == null) {
      print('No User Found!');
    }
    _me = UserModel.fromJson(responseBody);
    notifyListeners();
  }

  Future<void> fetchMyNotifications() async {
    final List<NotificationModel> fetchedNotifications = [];
    final responseBody =
    await _apiProvider.get('/users/me/notifications', token: _token) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedNotifications.add(NotificationModel.fromJson(element));
    });
    _notifications = fetchedNotifications;
    notifyListeners();
  }

  void _handleAuthenticationResponse(dynamic authenticationResponse) {
    _token = authenticationResponse['token'];
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

  Future<void> _connectToNotificationsSocket(String userId) async {
    await customStomp.connect(
      'ws://192.168.162.241:8080/ws',
      onConnect: (StompClient client, Map<String, String> headers) {
        _client = client;
        _client.subscribeJson(
          userId,
          '/topics/notifications/$userId',
          _acceptNotification,
        );
      },
      onFault: _handleWebSocketConnectionError,
    );
    notifyListeners();
  }

  void _disconnectFromNotificationsSocket(String userId) {
    if (_client != null) {
      if (!_client.isDisconnected) {
        _client.unsubscribe(userId);
      }
      _client = null;
    }
  }

  void _acceptNotification(Map<String, String> headers, dynamic message) {
    try {
      _lastNotificationDate = DateTime.tryParse(message);
      notifyListeners();
    } catch (e) {
      // do nothing
    }
  }

  void _scheduleAutoLogout() {
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

  void _handleWebSocketConnectionError(StompClient client, error, stackTrace) {
    // do nothing for the moment
  }

}