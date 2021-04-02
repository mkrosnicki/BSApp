import 'package:BSApp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Init {
  static Future initialize(BuildContext context) async {
    await _tryLogin(context);
    await _justWait();
  }

  static _tryLogin(BuildContext context) async {
    await Provider.of<Auth>(context).tryAutoLogin();
  }

  static _justWait() async {
    await Future.delayed(Duration(seconds: 1));
  }
}