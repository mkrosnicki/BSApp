import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/change_password_screen.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/profile/your_activity_screen.dart';
import 'package:BSApp/screens/profile/your_deals_screen.dart';
import 'package:BSApp/screens/profile/your_topics_screen.dart';
import 'package:BSApp/widgets/profile/logout_button.dart';
import 'package:BSApp/widgets/profile/my_profile_option_item.dart';
import 'package:BSApp/widgets/profile/my_profile_options_header.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileOptionsList extends StatelessWidget {
  final UsersProfileModel usersProfile;

  const MyProfileOptionsList(this.usersProfile);

  @override
  Widget build(BuildContext context) {
    final menuOptions = [
      const MyProfileOptionsHeader('Twoja aktywność'),
      const MyProfileOptionItem(
          title: 'Lista aktywności',
          route: YourActivityScreen.routeName),
      const MyProfileOptionItem(
          title: 'Twoje okazje',
          route: YourDealsScreen.routeName),
      const MyProfileOptionItem(
          title: 'Twoje tematy',
          route: YourTopicsScreen.routeName),
      const MyProfileOptionsHeader('Ustawienia'),
      const MyProfileOptionItem(title: 'Edytuj profil', route: '/favourites'),
      const MyProfileOptionItem(
          title: 'Zmień hasło', route: ChangePasswordScreen.routeName),
      const MyProfileOptionItem(title: 'Ustawienia e-mail', route: '/favourites'),
      MyProfileOptionItem(
        title: 'Usuń konto',
        route: DealsScreen.routeName,
        function: () => _deleteAccountFunction(context),
      ),
      const MyProfileOptionsHeader('Informacje'),
      const MyProfileOptionItem(title: 'Kontakt', route: '/favourites'),
      const MyProfileOptionItem(title: 'Regulamin', route: '/favourites'),
      const MyProfileOptionItem(
          title: 'Polityka prywatności', route: '/favourites'),
      const MyProfileOptionItem(title: 'O aplikacji', route: '/favourites'),
      const LogoutButton(),
    ];
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) => menuOptions[index],
        itemCount: menuOptions.length,
      ),
    );
  }

  Future<bool> _deleteAccountFunction(BuildContext context) async {
    final shouldDelete = await confirm(
      context,
      textOK: const Text('POTWIERDZAM - Usuń konto'),
      textCancel: const Text('Anuluj'),
      title: const Text('Usuwanie konta'),
      content: const Text(
          'Czy jesteś pewien, że chcesz usunąć konto? Nie można cofnąć tej operacji!'),
    );
    if (shouldDelete) {
      await Provider.of<Auth>(context, listen: false).deleteAccount();
    }
    return Future.value(shouldDelete);
  }
}
