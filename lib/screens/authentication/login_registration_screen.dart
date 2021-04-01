import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/app_bar_close_button.dart';
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
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: const AppBarCloseButton(Colors.white),
          backgroundColor: MyColorsProvider.BLUE,
          bottom: TabBar(
            indicatorWeight: 3.0,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelPadding: EdgeInsets.all(0),
            tabs: [
              _buildTabBar('Zaloguj się'),
              _buildTabBar('Stwórz konto'),
            ],
          ),
        ),
        body: TabBarView(
          children: [LoginForm(), RegistrationForm()],
        ),
      ),
    );
  }

  _buildTabBar(String label) {
    return Tab(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              // decoration: BoxDecoration(
              //     border: Border(
              //         bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5))),
              // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: Center(child: Text(label)),
            ),
          ),
        ],
      ),
    );
  }
}
