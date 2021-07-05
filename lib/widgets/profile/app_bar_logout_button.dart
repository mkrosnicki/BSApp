import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/services/custom_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarLogoutButton extends StatelessWidget {
  const AppBarLogoutButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _confirmLogout(context),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.square_arrow_left, color: Colors.white,),
      ),
    );
  }


  Future<bool> _confirmLogout(BuildContext context) async {
    final shouldLogout = await confirmDialog(
      context,
      textOK: 'Wyloguj się',
      textCancel: 'Nie',
      title: 'Wylogowanie',
      textContent: 'Czy chcesz się wylogować?',
    );
    if (shouldLogout) {
      await _logout(context);
    }
    return Future.value(shouldLogout);
  }

  Future<void> _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
