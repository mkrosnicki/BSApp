import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginRegistrationScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _LoginRegistrationScreenState createState() =>
      _LoginRegistrationScreenState();
}

class _LoginRegistrationScreenState extends State<LoginRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(85.0),
          child: BaseAppBar(
            title: 'Witaj',
            leading: AppBarCloseButton(Colors.black),
            bottom: DecoratedTabBar(
              tabBar: TabBar(
                labelPadding: EdgeInsets.all(10.0),
                indicatorColor: MyColorsProvider.DEEP_BLUE,
                labelColor: Colors.black,
                labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
                unselectedLabelStyle:
                    MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
                tabs: [
                  Text('Zaloguj się'),
                  Text('Stwórz konto'),
                ],
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

  Widget _buildTabBar(String label) {
    return Tab(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Center(child: Text(label)),
            ),
          ),
        ],
      ),
    );
  }
}
