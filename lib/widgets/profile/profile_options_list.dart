import 'package:BSApp/models/users_profile_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/authentication/change_password_screen.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/profile/added_deals_screen.dart';
import 'package:BSApp/screens/profile/added_topics_screen.dart';
import 'package:BSApp/screens/profile/your_activity_screen.dart';
import 'package:BSApp/widgets/profile/logout_button.dart';
import 'package:BSApp/widgets/profile/profile_option_item.dart';
import 'package:BSApp/widgets/profile/profile_options_header.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsList extends StatelessWidget {
  final UsersProfileModel usersProfile;

  ProfileOptionsList(this.usersProfile);

  @override
  Widget build(BuildContext context) {
    final menuOptions = [
      const ProfileOptionsHeader('Twoja aktywność'),
      ProfileOptionItem(
          title: 'Lista aktywności',
          route: YourActivityScreen.routeName,
          arguments: usersProfile.activities),
      ProfileOptionItem(
          title: 'Twoje okazje',
          route: AddedDealsScreen.routeName,
          arguments: usersProfile.addedDeals),
      ProfileOptionItem(
          title: 'Twoje wątki',
          route: AddedTopicsScreen.routeName,
          arguments: usersProfile.addedTopics),
      const ProfileOptionsHeader('Ustawienia'),
      const ProfileOptionItem(title: 'Edytuj profil', route: '/favourites'),
      const ProfileOptionItem(
          title: 'Zmień hasło', route: ChangePasswordScreen.routeName),
      const ProfileOptionItem(title: 'Ustawienia e-mail', route: '/favourites'),
      ProfileOptionItem(
        title: 'Usuń konto',
        route: DealsScreen.routeName,
        function: () => _deleteAccountFunction(context),
      ),
      const ProfileOptionsHeader('Informacje'),
      const ProfileOptionItem(title: 'Kontakt', route: '/favourites'),
      const ProfileOptionItem(title: 'Regulamin', route: '/favourites'),
      const ProfileOptionItem(
          title: 'Polityka prywatności', route: '/favourites'),
      const ProfileOptionItem(title: 'O aplikacji', route: '/favourites'),
      LogoutButton(),
    ];
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) => menuOptions[index],
        itemCount: menuOptions.length,
      ),
    );
  }

  Future<bool> _deleteAccountFunction(BuildContext context) async {
    var shouldDelete = await confirm(
      context,
      textOK: Text('POTWIERDZAM - Usuń konto'),
      textCancel: Text('Anuluj'),
      title: Text('Usuwanie konta'),
      content: Text(
          'Czy jesteś pewien, że chcesz usunąć konto? Nie można cofnąc tej operacj!'),
    );
    if (shouldDelete) {
      await Provider.of<Auth>(context, listen: false).deleteAccount();
    }
    return Future.value(shouldDelete);
  }
}
