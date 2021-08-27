import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:BSApp/widgets/common/tab_bar_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRegistrationScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _LoginRegistrationScreenState createState() => _LoginRegistrationScreenState();
}

class _LoginRegistrationScreenState extends State<LoginRegistrationScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96.0),
          child: BaseAppBar(
            title: 'Witaj',
            leading: const AppBarCloseButton(Colors.white),
            bottom: DecoratedTabBar(
              decoration: MyStylingProvider.DEFAULT_TAB_BAR_DECORATION,
              tabBar: TabBarFactory.withTabs(
                ['Zaloguj się', 'Stwórz konto'],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            LoginForm(),
            RegistrationForm(),
          ],
        ),
      ),
    );
  }
}
