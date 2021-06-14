import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Init {
  static Future initialize(BuildContext context) async {
    await _tryLogin(context);
    await _fetchCategories(context);
    await _justWait();
  }

  static Future<void> _tryLogin(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).tryAutoLogin();
  }

  static Future<void> _fetchCategories(BuildContext context) async {
    await Provider.of<Categories>(context, listen: false).fetchCategories();
  }

  static Future<void> _justWait() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
