import 'package:BSApp/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () => _logout(context),
        child: Text('Wyloguj'),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
