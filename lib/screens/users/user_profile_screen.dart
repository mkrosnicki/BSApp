import 'package:BSApp/models/user_details_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/users.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/form_field_divider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/user/user_profile_content.dart';
import 'package:BSApp/widgets/user/user_profile_main_info.dart';
import 'package:BSApp/widgets/user/user_profile_scrollable_menu.dart';
import 'package:BSApp/widgets/user/user_profile_statistics_info.dart';
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
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Profil użytkownika',
        leading: const AppBarBackButton(Colors.white),
        actions: [
          Consumer<CurrentUser>(
            builder: (context, currentUser, child) {
              return currentUser.isAdmin ? UserScreenAdminActionsButton(_user, _updateScreen) : Container();
            },
          ),
        ],
      ),
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
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  color: MyColorsProvider.BACKGROUND_COLOR,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          Flexible(
                            flex: 35,
                            child: UserProfileMainInfo(_user),
                          ),
                          Flexible(
                            flex: 65,
                            child: UserProfileStatisticsInfo(_user),
                          ),
                        ],
                      ),
                      const FormFieldDivider(),
                      UserProfileScrollableMenu(_contentIdSubject),
                      UserProfileContent(userId, _contentIdSubject),
                    ],
                  ),
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
    _user = await Provider.of<Users>(context, listen: false).findUser(userId);
  }

  void _updateScreen() {
    setState(() {});
  }
}
