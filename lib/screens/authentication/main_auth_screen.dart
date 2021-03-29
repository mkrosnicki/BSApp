import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/profile/profile_options_user_info.dart';
import 'package:flutter/material.dart';

import 'login_registration_screen.dart';

class MainAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ProfileOptionsUserInfo(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
              child: ElevatedButton(
                child: Text('Zaloguj się lub Załóż konto'),
                onPressed: () => _showLoginScreen(context),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(3),
    );
  }

  _showLoginScreen(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoginRegistrationScreen();
        },
        fullscreenDialog: true));
  }
}
