import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/providers/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  static const routeName = '/user-profile';

  UserModel _user;

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments as String;
    return FutureBuilder(
        future: _initUser(context, userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(_user.username),
                ),
                body: Center(
                  child: Text('Profil użytkownika'),
                ),
              );
            }
          }
        });
  }

  _initUser(BuildContext context, String userId) async {
    _user = await Provider.of<Users>(context, listen: false).findUser(userId);
  }
}
