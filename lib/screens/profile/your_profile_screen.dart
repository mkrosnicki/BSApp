import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/authentication/main_auth_screen.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/profile/app_bar_logout_button.dart';
import 'package:BSApp/widgets/profile/my_profile_options_list.dart';
import 'package:BSApp/widgets/profile/my_profile_statistics_info.dart';
import 'package:BSApp/widgets/profile/profile_user_info.dart';
import 'package:flutter/cupertino.dart';
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
            appBar: BaseAppBar(
              title: 'Twój profil',
              actions: [
                const AppBarLogoutButton(),
              ],
            ),
            body: SafeArea(
              child: FutureBuilder(
                future: Provider.of<CurrentUser>(context, listen: false).fetchMe(),
                builder: (context, snapshot) {
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
                      return Consumer<CurrentUser>(
                        builder: (context, currentUserData, child) {
                          return ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ProfileUserInfo(currentUserData.me),
                              ),
                              MyProfileStatisticsInfo(currentUserData.me),
                              const MyProfileOptionsList(),
                            ],
                          );
                        },
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
