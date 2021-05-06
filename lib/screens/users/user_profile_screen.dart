import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/common/zero_app_bar.dart';
import 'package:BSApp/widgets/user/user_profile_content.dart';
import 'package:BSApp/widgets/user/user_profile_main_info.dart';
import 'package:BSApp/widgets/user/user_profile_scrollable_menu.dart';
import 'package:BSApp/widgets/user/user_profile_statistics_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  UsersProfileModel _usersProfile;

  final PublishSubject<int> _contentIdSubject = PublishSubject<int>();

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: const ZeroAppBar(),
      body: FutureBuilder(
          future: _initUser(context, userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LoadingIndicator());
            } else {
              if (snapshot.error != null) {
                return const Center(
                  child: ServerErrorSplash(),
                );
              } else {
                return Stack(
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        UserProfileMainInfo(_usersProfile.user),
                        UserProfileStatisticsInfo(),
                        UserProfileScrollableMenu(_contentIdSubject),
                        UserProfileContent(_usersProfile, _contentIdSubject),
                      ],
                    ),
                    Container(
                      // color: Colors.green,
                      width: 70,
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const AppBarBackButton(Colors.black),
                    )
                  ],
                );
              }
            }
          }),
    );
  }

  @override
  void dispose() {
    _contentIdSubject.close();
    super.dispose();
  }

  Future<void> _initUser(BuildContext context, String userId) async {
    _usersProfile = await Provider.of<Users>(context, listen: false).findUsersProfile(userId);
  }
}
