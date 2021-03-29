import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/main_auth_screen.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/profile/profile_options_list.dart';
import 'package:BSApp/widgets/profile/profile_options_user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsScreen extends StatelessWidget {
  static const routeName = '/profile-options';

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, child) {
      if (auth.isAuthenticated) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: AppBar(),
          ),
          backgroundColor: Colors.white,
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
