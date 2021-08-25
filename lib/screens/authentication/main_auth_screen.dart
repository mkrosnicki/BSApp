import 'package:BSApp/screens/profile/about_app_screen.dart';
import 'package:BSApp/screens/profile/contact_screen.dart';
import 'package:BSApp/screens/profile/privacy_policy_screen.dart';
import 'package:BSApp/screens/profile/regulations_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/authentication/app_logo_header.dart';
import 'package:BSApp/widgets/common/zero_app_bar.dart';
import 'package:BSApp/widgets/profile/my_profile_option_item.dart';
import 'package:BSApp/widgets/profile/my_profile_options_header.dart';
import 'package:flutter/material.dart';

import 'auth_screen_provider.dart';
import 'curve_painter.dart';

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
          Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: MyColorsProvider.BACKGROUND_COLOR,
                child: CustomPaint(
                  painter: CurvePainter(),
                ),
              ),
              Positioned(
                right: MediaQuery.of(context).size.width * 0.15,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  alignment: Alignment.centerRight,
                  // color: Colors.green,
                  padding: EdgeInsets.only(
                      top: 50.0,
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.02),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => AuthScreenProvider.showLoginScreen(context),
                        child: Text(
                          'Zaloguj się',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                      ),
                      // Text('lub', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),),
                      // Text('Załóż konto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ],
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
