import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/main_auth_screen.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:BSApp/widgets/profile_option_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsScreen extends StatelessWidget {
  static const routeName = 'profile-options';

  @override
  Widget build(BuildContext context) {
    List<String> widgets = List.generate(10, (index) => 'Option number $index');
    return Consumer<Auth>(builder: (context, auth, child) {
      if (auth.isAuthenticated) {
        return Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) =>
                ProfileOptionItem(widgets[index], widgets[index]),
            itemCount: 10,
          ),
          bottomNavigationBar: MyNavigationBar(3),
        );
      } else {
        return MainAuthScreen();
        // return AuthScreen();
      }
    });
  }
}
