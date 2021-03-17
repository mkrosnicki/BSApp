import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/profile/added_comments_screen.dart';
import 'package:BSApp/screens/profile/added_deals_screen.dart';
import 'package:BSApp/services/api_provider.dart';
import 'package:BSApp/widgets/profile/profile_option_item.dart';
import 'package:BSApp/widgets/profile/profile_options_header.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileOptionsList extends StatelessWidget {
  ApiProvider apiProvider = ApiProvider();

  @override
  Widget build(BuildContext context) {
    final menuOptions = [
      const ProfileOptionsHeader('Twoja aktywność'),
      const ProfileOptionItem(
          title: 'Dodane okazje', route: AddedDealsScreen.routeName),
      const ProfileOptionItem(title: 'Dodane posty', route: '/favourites'),
      const ProfileOptionItem(
          title: 'Dodane komentarze', route: AddedCommentsScreen.routeName),
      const ProfileOptionsHeader('Obserwowane'),
      const ProfileOptionItem(title: 'title1', route: '/favourites'),
      const ProfileOptionItem(title: 'title1', route: '/favourites'),
      const ProfileOptionItem(title: 'title1', route: '/favourites'),
      const ProfileOptionItem(title: 'title1', route: '/favourites'),
      const ProfileOptionsHeader('Ustawienia'),
      const ProfileOptionItem(title: 'Edytuj profil', route: '/favourites'),
      const ProfileOptionItem(title: 'Zmień hasło', route: '/favourites'),
      const ProfileOptionItem(title: 'Ustawienia e-mail', route: '/favourites'),
      ProfileOptionItem(
        title: 'Usuń konto',
        route: DealsScreen.routeName,
        function: () => _deleteAccountFunction(context),
      ),
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
      content: Text('Czy jesteś pewien, że chcesz usunąć konto? Nie można cofnąc tej operacj!'),
    );
    if (shouldDelete) {
      await Provider.of<Auth>(context, listen: false).deleteAccount();
    }
    return Future.value(shouldDelete);
  }
}
