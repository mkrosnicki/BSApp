import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/services/custom_stomp' as customStomp;
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:stomp/stomp.dart';

class CurrentUserInfo with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  StompClient client;
  int _unreadNotifications = 0;
  List<NotificationModel> notifications = [];
  UserModel _me;
  String userId;
  String token;

  CurrentUserInfo.empty();

  UserModel get me {
    return _me;
  }

  DateTime get notificationsSeenAt {
    return _me != null ? _me.registeredAt : null;
  }

  int get unreadNotificationsCount {
    return _unreadNotifications;
  }

  bool get newNotificationsPresent {
    return unreadNotificationsCount > 0;
  }

  List<NotificationModel> get myNotifications {
    return [...notifications];
  }

  Future<void> updateNotificationsSeenAt() async {
    final responseBody = await _apiProvider.patch(
        '/users/me/',
        {'notificationsSeenAtUpdate': true},
        token: token
    );
    if (responseBody == null) {
      print('No User Found!');
    }
    _me = UserModel.fromJson(responseBody);
  }

  Future<void> fetchMyNotifications() async {
    final List<NotificationModel> fetchedNotifications = [];
    final responseBody =
    await _apiProvider.get('/users/me/notifications', token: token) as List;
    if (responseBody == null) {
      print('No Deals Found!');
    }
    responseBody.forEach((element) {
      fetchedNotifications.add(NotificationModel.fromJson(element));
    });
    notifications = fetchedNotifications;
    notifyListeners();
  }

  _connectNotificationsSocket(String userId) {
    print(userId);
    customStomp.connect(
      'ws://192.168.162.241:8080/ws',
      onConnect: (StompClient client, Map<String, String> headers) {
        this.client = client;
        this.client.subscribeString(
          userId,
          '/topics/notifications/$userId',
          _acceptNotification,
        );
      },
      onFault: _handleError,
    );
  }

  _disconnectNotificationsSocket(String userId) {
    if (this.client != null) {
      this.client.unsubscribe(userId);
      this.client = null;
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

  void update(Auth auth, CurrentUserInfo previousUserInfo) async {
    print('update user info');
    if (auth.token == null) {
      _handleUserNotLogged(auth, previousUserInfo);
    } else {
      _handleUserLoggedIn(auth, previousUserInfo);
    }
  }

  void _handleUserNotLogged(Auth auth, CurrentUserInfo previousUserInfo) {
    _unreadNotifications = 0;
    _disconnectNotificationsSocket(userId);
    userId = null;
    token = null;
    this._me = null;
  }

  void _handleUserLoggedIn(Auth auth, CurrentUserInfo previousUserInfo) async {
    token = auth.token;
    userId = auth.userId;
    _me = auth.me;
    await _connectNotificationsSocket(auth.userId);
    notifyListeners();
  }
}
