import 'package:BSApp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white
            ],
          )
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              minRadius: 40,
              maxRadius: 40,
              backgroundImage: NetworkImage(
                'https://img.favpng.com/25/13/19/samsung-galaxy-a8-a8-user-login-telephone-avatar-png-favpng-dqKEPfX7hPbc6SMVUCteANKwj.jpg',
              ),
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

  // Center(
  // child: Container(
  // decoration: BoxDecoration(
  // gradient: LinearGradient(
  // begin: Alignment.topRight,
  // end: Alignment.bottomLeft,
  // colors: [
  // Colors.blue,
  // Colors.red,
  // ],
  // )
  // ),
  // child: Center(
  // child: Text(
  // 'Hello Gradient!',
  // style: TextStyle(
  // fontSize: 48.0,
  // fontWeight: FontWeight.bold,
  // color: Colors.white,
  // ),
  // ),
  // ),
  // ),
  // ),

  void _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
