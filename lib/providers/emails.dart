import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';

class Emails with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();
  String _token;

  Emails.empty();

  Future<bool> sendEmail(final String subject, final String content, final String authorEmail) async {
    try {
      final responseBody = await _apiProvider
          .post('/emails', {'subject': subject, 'content': content, 'authorEmail': authorEmail}, token: _token);
      return responseBody == 'Sent';
    } catch (e) {
      return false;
    }
  }

  void update(String token) {
    _token = token;
  }
}
