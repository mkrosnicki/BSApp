import 'package:BSApp/screens/profile/about_app_screen.dart';
import 'package:BSApp/screens/profile/contact_screen.dart';
import 'package:BSApp/screens/profile/privacy_policy_screen.dart';
import 'package:BSApp/screens/profile/regulations_screen.dart';
import 'package:BSApp/widgets/authentication/main_auth_screen_header.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/profile/my_profile_option_item.dart';
import 'package:BSApp/widgets/profile/my_profile_options_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth_screen_provider.dart';

class MainAuthScreen extends StatelessWidget {
  final menuOptions = [
    const MyProfileOptionsHeader('Informacje'),
    const MyProfileOptionItem(title: 'Kontakt', route: ContactScreen.routeName),
    const MyProfileOptionItem(title: 'Regulamin', route: RegulationsScreen.routeName),
    const MyProfileOptionItem(title: 'Polityka prywatności', route: PrivacyPolicyScreen.routeName),
    const MyProfileOptionItem(title: 'O aplikacji', route: AboutAppScreen.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        brightness: Brightness.light,
        backwardsCompatibility: false,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const MainAuthScreenHeader(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Zaloguj się aby korzystać ze wszystkich funkcjonalności.',
                style: TextStyle(fontSize: 13),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.only(bottom: 20.0),
              child: PrimaryButton('Zaloguj się lub załóż konto', () => AuthScreenProvider.showLoginScreen(context)),
            ),
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) => menuOptions[index],
                itemCount: menuOptions.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
