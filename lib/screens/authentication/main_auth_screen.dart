import 'package:BSApp/screens/profile/about_app_screen.dart';
import 'package:BSApp/screens/profile/contact_screen.dart';
import 'package:BSApp/screens/profile/privacy_policy_screen.dart';
import 'package:BSApp/screens/profile/regulations_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/authentication/app_logo_header.dart';
import 'package:BSApp/widgets/common/primary_button.dart';
import 'package:BSApp/widgets/common/zero_app_bar.dart';
import 'package:BSApp/widgets/profile/my_profile_option_item.dart';
import 'package:BSApp/widgets/profile/my_profile_options_header.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: MyColorsProvider.BACKGROUND_COLOR,
      appBar: const ZeroAppBar(),
      body: Column(
        children: [
          const AppLogoHeader(),
          Container(
            width: double.infinity,
            // color: Colors.white,
            padding: EdgeInsets.only(
                top: 30.0,
                bottom: 30.0,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
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
    );
  }
}
