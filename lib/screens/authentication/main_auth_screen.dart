import 'package:BSApp/widgets/common/primary-button.dart';
import 'package:BSApp/widgets/profile/profile_main_info.dart';
import 'package:BSApp/widgets/profile/profile_option_item.dart';
import 'package:BSApp/widgets/profile/profile_options_header.dart';
import 'package:BSApp/widgets/profile/profile_options_user_info.dart';
import 'package:flutter/material.dart';

import 'auth_screen_provider.dart';

class MainAuthScreen extends StatelessWidget {
  final menuOptions = [
    const ProfileOptionsHeader('Informacje'),
    const ProfileOptionItem(title: 'Kontakt', route: '/favourites'),
    const ProfileOptionItem(title: 'Regulamin', route: '/favourites'),
    const ProfileOptionItem(
        title: 'Polityka prywatności', route: '/favourites'),
    const ProfileOptionItem(title: 'O aplikacji', route: '/favourites'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ProfileMainInfo(null),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              child: Text(
                  'Zaloguj się aby korzystać ze wszystkich funkcjonalności.', style: const TextStyle(fontSize: 13),),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.only(bottom: 20.0),
              child: PrimaryButton('Zaloguj się lub załóż konto',
                  () => AuthScreenProvider.showLoginScreen(context)),
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
