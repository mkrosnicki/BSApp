import 'package:BSApp/models/notification_model.dart';
import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:BSApp/services/custom_stomp' as customStomp;
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:stomp/stomp.dart';

class Notifications with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  StompClient _client;
  DateTime _lastNotificationDate;
  DateTime _notificationsSeenAt;
  List<NotificationModel> _notifications = [];
  StompClient client;
  UserDetailsModel me;
  String _token;


  Notifications.empty();


  DateTime get notificationsSeenAt {
    return _notificationsSeenAt;
  }

  bool get areUnseenNotifications {
    if (_notificationsSeenAt != null && _lastNotificationDate != null) {
      return _notificationsSeenAt.isBefore(_lastNotificationDate);
    }
    return false;
  }

  List<NotificationModel> get myNotifications {
    return [..._notifications];
  }

  Future<void> fetchMyNotifications() async {
    final responseBody =
    await _apiProvider.get('/users/me/notifications', token: _token) as List;
    if (responseBody == null) {
      print('No Notifications Found!');
    }
    _notifications = NotificationModel.fromJsonList(responseBody);
  }

  Future<void> deleteMyNotifications() async {
    await _apiProvider.delete('/users/me/notifications', token: _token);
    _lastNotificationDate = null;
    _notifications = [];
    notifyListeners();
  }

  void updateNotificationsTimestamp() {
    _notificationsSeenAt = DateTime.now();
    notifyListeners();
  }

  Future<void> _connectToNotificationsSocket(String userId) async {
    await customStomp.connect(
      'ws://${ApiProvider.domain}/ws',
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
      _lastNotificationDate = DateUtil.parseFromStringToUtc(message);
      notifyListeners();
    } catch (e) {
      // do nothing
    }
  }

  void _handleWebSocketConnectionError(StompClient client, error, stackTrace) {
    // do nothing for the moment
  }

  Future<void> update(String token, String userId, DateTime notificationsSeenAt) async {
    if (token == null || userId == null) {
      _disconnectFromNotificationsSocket(userId);
      _token = null;
      _notificationsSeenAt = null;
      _lastNotificationDate = null;
    } else {
      _token = token;
      _notificationsSeenAt = notificationsSeenAt;
      _connectToNotificationsSocket(userId);
      await fetchMyNotifications();
      _lastNotificationDate = _notifications.isNotEmpty ? _notifications.first.issuedAt : null;
      notifyListeners();
    }
  }

  Future<void> updateAllClickedAt() async {
    final List<String> allIds = _notifications.where((element) => !element.wasClicked).map((e) => e.id).toList();
    await updateClickedAt(allIds, DateTime.now().toUtc());
  }

  Future<void> updateClickedAt(List<String> ids, DateTime clickedAt) async {
    if (ids.isNotEmpty) {
      await _apiProvider.patch('/users/me/notifications', {'ids': ids, 'clickedAt': clickedAt.toIso8601String()}, token: _token);
      await fetchMyNotifications();
      notifyListeners();
    }
  }
}
