import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/services/custom_stomp' as customStomp;
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:stomp/stomp.dart';

class MyInfo with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  StompClient _client;
  int _unreadNotifications = 0;
  List<NotificationModel> _notifications = [];
  UserModel _me;
  String _userId;
  String _token;

  MyInfo.empty();

  UserModel get me {
    return _me;
  }

  DateTime get notificationsSeenAt {
    return _me != null ? _me.notificationsSeenAt : null;
  }

  int get unreadNotificationsCount {
    return _unreadNotifications;
  }

  bool get newNotificationsPresent {
    return unreadNotificationsCount > 0;
  }

  List<NotificationModel> get myNotifications {
    return [..._notifications];
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

  _connectNotificationsSocket(String userId) {
    print(userId);
    customStomp.connect(
      'ws://192.168.162.241:8080/ws',
      onConnect: (StompClient client, Map<String, String> headers) {
        this._client = client;
        this._client.subscribeString(
          userId,
          '/topics/notifications/$userId',
          _acceptNotification,
        );
      },
      onFault: _handleError,
    );
  }

  _disconnectNotificationsSocket(String userId) {
    if (this._client != null) {
      this._client.unsubscribe(userId);
      this._client = null;
    }
  }

  _acceptNotification(Map<String, String> headers, String message) {
    try {
      this._unreadNotifications = int.tryParse(message);
      notifyListeners();
    } catch (e) {
      // do nothing
    }
  }

  _handleError(StompClient client, error, stackTrace) {
    // do nothing for the moment
  }

  void update(Auth auth, MyInfo previousUserInfo) async {
    print('update user info');
    if (auth.token == null) {
      _handleUserNotLogged(auth, previousUserInfo);
    } else {
      _handleUserLoggedIn(auth, previousUserInfo);
    }
  }

  void _handleUserNotLogged(Auth auth, MyInfo previousUserInfo) {
    _unreadNotifications = 0;
    _disconnectNotificationsSocket(_userId);
    _userId = null;
    _token = null;
    this._me = null;
  }

  void _handleUserLoggedIn(Auth auth, MyInfo previousUserInfo) async {
    _token = auth.token;
    _userId = auth.userId;
    _me = auth.me;
    await _connectNotificationsSocket(auth.userId);
    notifyListeners();
  }
}
