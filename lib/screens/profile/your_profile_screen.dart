import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/screens/authentication/main_auth_screen.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/profile/my_profile_options_list.dart';
import 'package:BSApp/widgets/profile/my_profile_statistics_info.dart';
import 'package:BSApp/widgets/profile/profile_user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YourProfileScreen extends StatefulWidget {
  static const routeName = '/your-profile';

  @override
  _YourProfileScreenState createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {

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
                    return const Center(
                      child: LoadingIndicator(),
                    );
                  } else {
                    if (snapshot.error != null) {
                      return const Center(
                        child: ServerErrorSplash(),
                      );
                    } else {
                      return Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileUserInfo(auth.me),
                            MyProfileStatisticsInfo(),
                            MyProfileOptionsList(usersProfile),
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
