import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/colored_tab.dart';
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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: BaseAppBar(
            title: 'Witaj',
            leading: AppBarCloseButton(Colors.white),
            bottom: DecoratedTabBar(
              tabBar: TabBar(
                labelPadding: EdgeInsets.zero,
                indicatorColor: MyColorsProvider.PASTEL_LIGHT_BLUE,
                labelColor: Colors.white,
                labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
                unselectedLabelStyle: MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: [
                  ColoredTab('Zaloguj się', _selectedIndex == 0),
                  ColoredTab('Stwórz konto', _selectedIndex == 1),
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
