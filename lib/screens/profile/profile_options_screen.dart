import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/main_auth_screen.dart';
import 'package:BSApp/widgets/profile/profile_user_info.dart';
import 'package:BSApp/widgets/profile/profile_options_list.dart';
import 'package:BSApp/widgets/profile/profile_statistics_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsScreen extends StatelessWidget {
  static const routeName = '/profile-options';

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(builder: (context, auth, child) {
      if (auth.isAuthenticated) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileUserInfo(auth.me),
                  ProfileStatisticsInfo(),
                  ProfileOptionsList(),
                ],
              ),
            ),
          ),
        );
      } else {
        return MainAuthScreen();
        // return AuthScreen();
      }
    });
  }
}
