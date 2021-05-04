import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/screens/authentication/main_auth_screen.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/profile/profile_options_list.dart';
import 'package:BSApp/widgets/profile/profile_statistics_info.dart';
import 'package:BSApp/widgets/profile/profile_user_info.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

class ProfileOptionsScreen extends StatefulWidget {
  static const routeName = '/profile-options';

  @override
  _ProfileOptionsScreenState createState() => _ProfileOptionsScreenState();
}

class _ProfileOptionsScreenState extends State<ProfileOptionsScreen> {
  UsersProfileModel _usersProfile;

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) {
        if (auth.isAuthenticated) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: FutureBuilder(
                future: Provider.of<Users>(context, listen: false)
                    .fetchUsersProfile(auth.userId),
                builder: (context, snapshot) {
                  final UsersProfileModel usersProfile =
                      Provider.of<Users>(context, listen: false)
                          .getUsersProfile(auth.userId);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: JumpingDotsProgressIndicator(
                        fontSize: 40.0,
                      ),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: const ServerErrorSplash(),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ProfileUserInfo(auth.me),
                            ProfileStatisticsInfo(),
                            ProfileOptionsList(usersProfile),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          );
        } else {
          return MainAuthScreen();
          // return AuthScreen();
        }
      },
    );
  }
}
