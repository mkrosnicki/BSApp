import 'package:BSApp/widgets/authentication/login_form.dart';
import 'package:BSApp/widgets/authentication/registration_form.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
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
    var blackText = TextStyle(color: Colors.black87);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Witaj w BSAPP!', style: blackText,),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: Icon(CupertinoIcons.clear, color: Colors.black87,),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: Text('Zaloguj się'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                child: Text('Stwórz konto'),
              ),
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
