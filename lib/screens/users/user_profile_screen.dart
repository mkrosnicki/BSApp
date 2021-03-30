import 'package:BSApp/models/user_model.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/profile/user_profile_content.dart';
import 'package:BSApp/widgets/profile/user_profile_main_info.dart';
import 'package:BSApp/widgets/profile/user_profile_scrollable_menu.dart';
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
                title: Text(
                  'Profil',
                  style: TextStyle(color: Colors.black),
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
            );
          }
        }
      },
    );
  }

  _initUser(BuildContext context, String userId) async {
    _user = await Provider.of<Users>(context, listen: false).findUser(userId);
  }
}
