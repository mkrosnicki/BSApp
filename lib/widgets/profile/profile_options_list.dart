import 'package:BSApp/screens/profile/added_comments_screen.dart';
import 'package:BSApp/screens/profile/added_deals_screen.dart';
import 'package:BSApp/widgets/profile/profile_option_item.dart';
import 'package:BSApp/widgets/profile/profile_options_header.dart';
import 'package:flutter/material.dart';

class ProfileOptionsList extends StatelessWidget {

  final List<Widget> menuOptions = [
    ProfileOptionsHeader('Twoja aktywność'),
    ProfileOptionItem('Dodane okazje', AddedDealsScreen.routeName),
    ProfileOptionItem('Dodane posty', '/favourites'),
    ProfileOptionItem('Dodane komentarze', AddedCommentsScreen.routeName),
    ProfileOptionsHeader('Obserwowane'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionItem('title1', '/favourites'),
    ProfileOptionsHeader('Ustawienia'),
    ProfileOptionItem('Edytuj profil', '/favourites'),
    ProfileOptionItem('Zmień hasło', '/favourites'),
    ProfileOptionItem('Ustawienia e-maili', '/favourites'),
    ProfileOptionItem('Usuń konto', '/favourites'),
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) => menuOptions[index],
        itemCount: menuOptions.length,
      ),
    );
  }
}
