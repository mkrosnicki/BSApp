import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {

  static const routeName = '/user-profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil użytkownika'),
      ),
      body: Center(
        child: Text('Profil użytkownika'),
      ),
    );
  }
}
