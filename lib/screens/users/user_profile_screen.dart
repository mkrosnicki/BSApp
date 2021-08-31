import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/user/user_profile_content.dart';
import 'package:BSApp/widgets/user/user_profile_main_info.dart';
import 'package:BSApp/widgets/user/user_profile_scrollable_menu.dart';
import 'package:BSApp/widgets/user/user_profile_statistics_info.dart';
import 'package:BSApp/widgets/user/user_profile_username.dart';
import 'package:BSApp/widgets/user/user_screen_admin_actions_button.dart';
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
  UserDetailsModel _user;

  final PublishSubject<int> _contentIdSubject = PublishSubject<int>();

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context).settings.arguments as String;
    return FutureBuilder(
        future: _initUser(context, userId),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: BaseAppBar(
              title: 'Profil użytkownika',
              leading: const AppBarBackButton(Colors.white),
              actions: [
                if (snapshot.connectionState != ConnectionState.waiting)
                  Consumer<CurrentUser>(
                    builder: (context, currentUser, child) {
                      return currentUser.isAdmin ? UserScreenAdminActionsButton(_user, _updateScreen) : Container();
                    },
                  ),
              ],
            ),
            body: SingleChildScrollView(
              child: snapshot.connectionState != ConnectionState.waiting
                  ? _loadedContent(userId)
                  : _notLoadedContent(snapshot),
            ),
          );
        });
  }

  Widget _loadedContent(final String userId) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      color: MyColorsProvider.BACKGROUND_COLOR,
      child: Flex(
        direction: Axis.vertical,
        children: [
          UserProfileUsername(_user),
          Stack(
            children: [
              Container(
                height: 120,
              ),
              Positioned(
                top: 22.0,
                right: 0,
                child: UserProfileStatisticsInfo(_user),
              ),
              Positioned(
                child: UserProfileMainInfo(_user),
              ),
            ],
          ),
          UserProfileScrollableMenu(_contentIdSubject),
          UserProfileContent(userId, _contentIdSubject),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _contentIdSubject.close();
    super.dispose();
  }

  Future<void> _initUser(BuildContext context, String userId) async {
    _user = await Provider.of<Users>(context, listen: false).findUser(userId);
  }

  void _updateScreen() {
    setState(() {});
  }

  Widget _notLoadedContent(snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: LoadingIndicator());
    } else {
      if (snapshot.error != null) {
        return const Center(
          child: ServerErrorSplash(),
        );
      } else {
        return Container();
      }
    }
  }
}
