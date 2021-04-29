import 'package:BSApp/screens/notifications/custom_stomp' as customStomp;
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:stomp/stomp.dart';

class Notifications with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  int _unreadNotifications = 0;
  StompClient client;
  String userId;
  String token;

  Notifications.empty();

  int get unreadNotifications {
    return _unreadNotifications;
  }

  _startSubscribing(String userId) {
    print(userId);
    customStomp.connect(
      'ws://192.168.162.241:8080/ws',
      onConnect: (StompClient client, Map<String, String> headers) {
        this.client = client;
        this.client.subscribeString(
          userId,
          '/topics/notifications/1',
          _acceptNotification,
        );
      },
      onFault: _handleError,
    );
  }

  _stopSubscribing(String userId) {
    this.client.unsubscribe(userId);
    this.client = null;
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

  void update(String token, String userId) async {
    print('update');
    if (token == null || userId == null) {
      _unreadNotifications = 0;
      this._stopSubscribing(userId);
      this.userId = null;
      this.token = null;
    } else {
      this.token = token;
      this.userId = userId;
      await _startSubscribing(userId);
    }
  }
}
