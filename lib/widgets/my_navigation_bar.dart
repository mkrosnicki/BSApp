import 'package:BSApp/screens/deals_screen.dart';
import 'package:BSApp/screens/favourites_screen.dart';
import 'package:BSApp/screens/forum_screen.dart';
import 'package:BSApp/screens/profile_options_screen.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  final int _selectedIndex;

  MyNavigationBar(this._selectedIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(99, 137, 217, 1),
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.white,
      unselectedItemColor: Color.fromRGBO(249, 250, 251, 1),
      currentIndex: _selectedIndex,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      onTap: (index) => navigate(context, index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: 'Okazje',
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Forum',
          icon: Icon(Icons.article_outlined),
          activeIcon: Icon(Icons.article),
        ),
        BottomNavigationBarItem(
          label: 'Ulubione',
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: 'Konto',
          icon: Icon(Icons.account_circle_outlined),
          activeIcon: Icon(Icons.account_circle),
        ),
        // BottomNavigationBarItem(
        //   label: 'Home',
        //   icon: Icon(Icons.access_alarm),
        // ),
      ],
    );
  }

  navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(ForumScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(FavouritesScreen.routeName);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(ProfileOptionsScreen.routeName);
        break;
    }
  }
}
