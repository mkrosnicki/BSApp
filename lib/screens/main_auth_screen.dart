import 'package:flutter/material.dart';

import 'login_screen.dart';

class MainAuthScreen extends StatelessWidget {

  _showLoginScreen(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoginScreen();
        },
        fullscreenDialog: true
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RaisedButton(
            child: Text('Zaloguj'),
            onPressed: () => _showLoginScreen(context),
          ),
          RaisedButton(
            child: Text('Zarejestruj'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
