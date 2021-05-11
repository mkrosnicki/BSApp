import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          brightness: Brightness.light,
          backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: MyColorsProvider.DEEP_BLUE),
          leading: const AppBarCloseButton(Colors.white),
          backgroundColor: MyColorsProvider.BLUE,
          bottom: const TabBar(
            indicatorWeight: 3.0,
            unselectedLabelStyle:
                TextStyle(fontSize: 13),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelPadding: EdgeInsets.all(10.0),
            tabs: [
              Text('Zaloguj się'),
              Text('Stwórz konto'),
            ],
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
