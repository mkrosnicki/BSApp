import 'package:flutter/material.dart';

import 'login_registration_screen.dart';

class AuthScreenProvider {

  static void showLoginScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoginRegistrationScreen();
        },
        fullscreenDialog: true));
  }
}