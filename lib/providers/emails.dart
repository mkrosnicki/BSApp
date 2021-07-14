import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Emails with ChangeNotifier {

  final ApiProvider _apiProvider = ApiProvider();

  Future<bool> sendEmail(final String subject, final String content, final String authorEmail) async {
    try {
      final responseBody = await _apiProvider.post('/emails', {
        'subject': subject,
        'content': content,
        'authorEmail': authorEmail
      });
      return responseBody == 'Sent';
    } catch (e) {
      return false;
    }
  }

}