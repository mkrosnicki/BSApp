import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/change_password_screen.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/profile/about_app_screen.dart';
import 'package:BSApp/screens/profile/contact_screen.dart';
import 'package:BSApp/screens/profile/privacy_policy_screen.dart';
import 'package:BSApp/screens/profile/regulations_screen.dart';
import 'package:BSApp/screens/profile/your_activity_screen.dart';
import 'package:BSApp/screens/profile/your_deals_screen.dart';
import 'package:BSApp/screens/profile/your_topics_screen.dart';
import 'package:BSApp/services/custom_confirm.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/profile/my_profile_option_item.dart';
import 'package:BSApp/widgets/profile/my_profile_options_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileOptionsList extends StatelessWidget {
  const MyProfileOptionsList();

  @override
  Widget build(BuildContext context) {
    final menuOptions = [
      const MyProfileOptionsHeader('Twoja aktywność'),
      const MyProfileOptionItem(title: 'Lista aktywności', route: YourActivityScreen.routeName),
      const MyProfileOptionItem(title: 'Twoje okazje', route: YourDealsScreen.routeName),
      const MyProfileOptionItem(title: 'Twoje tematy', route: YourTopicsScreen.routeName),
      const MyProfileOptionsHeader('Ustawienia'),
      // const MyProfileOptionItem(title: 'Edytuj profil', route: '/favourites'),
      const MyProfileOptionItem(title: 'Zmień hasło', route: ChangePasswordScreen.routeName),
      const MyProfileOptionItem(title: 'Ustawienia e-mail', route: '/favourites'),
      MyProfileOptionItem(
        title: 'Usuń konto',
        route: DealsScreen.routeName,
        function: () => _deleteAccountFunction(context),
      ),
      const MyProfileOptionsHeader('Informacje'),
      const MyProfileOptionItem(title: 'Kontakt', route: ContactScreen.routeName),
      const MyProfileOptionItem(title: 'Regulamin', route: RegulationsScreen.routeName),
      const MyProfileOptionItem(title: 'Polityka prywatności', route: PrivacyPolicyScreen.routeName),
      const MyProfileOptionItem(title: 'O aplikacji', route: AboutAppScreen.routeName),
    ];
    return Container(
      color: MyColorsProvider.BACKGROUND_COLOR,
      child: ListView.builder(
        itemBuilder: (context, index) => menuOptions[index],
        itemCount: menuOptions.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  Future<bool> _deleteAccountFunction(BuildContext context) async {
    final shouldDelete = await confirmDialog(
      context,
      textOK: 'Usuń konto',
      textCancel: 'Anuluj',
      title: 'Usuwanie konta',
      textContent: 'Czy jesteś pewien, że chcesz usunąć konto?\nNie można cofnąć tej operacji!',
    );
    if (shouldDelete) {
      await Provider.of<Auth>(context, listen: false).deleteAccount();
    }
    return Future.value(shouldDelete);
  }
}
