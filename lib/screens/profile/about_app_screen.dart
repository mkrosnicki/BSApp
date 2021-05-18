import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutAppScreen extends StatelessWidget {
  static const routeName = '/about-app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(
        leading: AppBarBackButton(Colors.black),
        title: 'O aplikacji',
      ),
      body: Text('O aplikacji'),
    );
  }
}
