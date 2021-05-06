import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:BSApp/services/custom_stomp' as customStomp;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stomp/stomp.dart';

class Notifications with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  int _unreadNotifications = 0;
  List<NotificationModel> notifications = [];
  StompClient client;
  String userId;
  String token;

  Notifications.empty();

  int get numberOfUnreadNotifications {
    return _unreadNotifications;
  }

  bool get areNewNotifications {
    return numberOfUnreadNotifications > 0;
  }

  List<NotificationModel> get myNotifications {
    return [...notifications];
  }

  Future<void> fetchMyNotifications() async {
    final List<NotificationModel> fetchedNotifications = [];
    final responseBody =
    await _apiProvider.get('/users/me/notifications', token: token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Notifications Found!');
    }
    responseBody.forEach((element) {
      fetchedNotifications.add(NotificationModel.fromJson(element));
    });
    notifications = fetchedNotifications;
    notifyListeners();
  }

  Future<void> _startSubscribing(String userId) {
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

  void _stopSubscribing(String userId) {
    if (client != null) {
      client.unsubscribe(userId);
      client = null;
    }
  }

  void _acceptNotification(Map<String, String> headers, String message) {
    try {
      _unreadNotifications = int.tryParse(message);
      notifyListeners();
    } catch (e) {
      // do nothing
    }
  }

  void _handleError(StompClient client, error, stackTrace) {
    // do nothing for the moment
  }

  Future<void> update(String token, String userId) async {
    if (token == null || userId == null) {
      _unreadNotifications = 0;
      _stopSubscribing(userId);
      this.userId = null;
      this.token = null;
    } else {
      this.token = token;
      this.userId = userId;
      await _startSubscribing(userId);
    }
  }
}
