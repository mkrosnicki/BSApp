import 'package:BSApp/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarLogoutButton extends StatelessWidget {
  const AppBarLogoutButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _logout(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(CupertinoIcons.square_arrow_left, color: Colors.white,),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logout();
  }
}
