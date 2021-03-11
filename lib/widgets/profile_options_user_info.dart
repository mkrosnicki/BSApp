import 'package:BSApp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
            child: RaisedButton(
              onPressed: () => _logout(context),
              child: Text('Wyloguj'),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
