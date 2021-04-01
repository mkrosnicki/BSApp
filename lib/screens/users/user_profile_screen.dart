import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/common/content_or_progress_indicator.dart';
import 'package:BSApp/widgets/profile/user_profile_content.dart';
import 'package:BSApp/widgets/profile/user_profile_main_info.dart';
import 'package:flutter/cupertino.dart';
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
      builder: (context, snapshot) => ContentOrProgressIndicator(
        snapshot: snapshot,
        content: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profil',
              style: MyStylingProvider.TEXT_BLACK,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: const AppBarBackButton(Colors.black),
            // bottom: AppBarBottomBorder(),
          ),
          body: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UserProfileMainInfo(_user),
              UserProfileContent(),
            ],
          ),
        ),
      ),
    );
  }

  _initUser(BuildContext context, String userId) async {
    _user = await Provider.of<Users>(context, listen: false).findUser(userId);
  }
}
