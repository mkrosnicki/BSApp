import 'package:BSApp/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: ListTile(
        title: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Text('Wyloguj się', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),),
        ),
        focusColor: Colors.grey,
      ),
      onPressed: () => _logout(context),
    );
  }

  void _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
