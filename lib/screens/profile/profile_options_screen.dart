import 'package:BSApp/providers/auth.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/screens/authentication/main_auth_screen.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/bars/my_navigation_bar.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/profile/profile_options_list.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/profile/profile_options_user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsScreen extends StatelessWidget {
  static const routeName = '/profile-options';

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, child) {
      if (auth.isAuthenticated) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ProfileOptionsUserInfo(),
                ProfileOptionsList(),
              ],
            ),
          ),
          bottomNavigationBar: MyNavigationBar(3),
        );
      } else {
        return MainAuthScreen();
        // return AuthScreen();
      }
    });
  }
}
