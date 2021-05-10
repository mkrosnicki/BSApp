import 'package:BSApp/models/activity_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Activities with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  List<ActivityModel> _activities = [];
  String _token;

  Activities.empty();

  List<ActivityModel> get activities {
    return [..._activities];
  }

  Future<void> fetchMyActivities() async {
    final responseBody =
        await _apiProvider.get('/users/me/activities', token: _token) as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Activities Found!');
    }
    _activities = ActivityModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> fetchUsersActivities(String userId) async {
    final responseBody =
        await _apiProvider.get('/users/$userId/activities') as List;
    if (responseBody == null) {
      final logger = Logger();
      logger.i('No Activities Found!');
    }
    _activities = ActivityModel.fromJsonList(responseBody);
    notifyListeners();
  }

  Future<void> update(String token, List<ActivityModel> activities) async {
    _token = token;
    _activities = activities;
  }
}
