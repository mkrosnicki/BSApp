import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'login_registration_screen.dart';

class MainAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg',
                  height: 80,
                ),
              ),
              Text(
                'Witaj w BSAPP',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  child: Text('Zaloguj się lub Załóż konto'),
                  onPressed: () => _showLoginScreen(context),
                ),
              ),
            ],
          ),
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
