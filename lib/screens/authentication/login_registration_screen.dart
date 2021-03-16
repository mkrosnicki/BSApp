import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
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
        appBar: AppBar(
          title: Text('Witaj!'),
          bottom: TabBar(
            tabs: [
              Text('Zaloguj się'),
              Text('Stwórz konto'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginForm(),
            RegistrationForm()
          ],
        ),
        bottomNavigationBar: MyNavigationBar(3),
      ),
    );
  }
}
