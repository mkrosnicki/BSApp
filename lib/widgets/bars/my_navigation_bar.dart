import 'package:BSApp/screens/deals/add_deal_screen.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/favourites/favourites_screen.dart';
import 'package:BSApp/screens/forum/forum_screen.dart';
import 'package:BSApp/screens/profile/profile_options_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  final int _selectedIndex;

  MyNavigationBar(this._selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5))),
      child: BottomNavigationBar(
          // Color.fromRGBO(99, 137, 217, 1)
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        fixedColor: Color.fromRGBO(99, 137, 217, 1),
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        // selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) => navigate(context, index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.rectangle_stack, size: 20,),
            // activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.bubble_left, size: 20),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.add, size: 20),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.suit_heart, size: 20),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(CupertinoIcons.line_horizontal_3, size: 20,),
          ),
          // BottomNavigationBarItem(
          //   label: 'Home',
          //   icon: Icon(Icons.access_alarm),
          // ),
        ],
      ),
    );
  }

  navigate(BuildContext context, int index) {
    final navigator = Navigator.of(context);
    while (navigator.canPop()) {
      navigator.pop();
    }
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed(DealsScreen.routeName);
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(ForumScreen.routeName);
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed(AddDealScreen.routeName);
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed(FavouritesScreen.routeName);
        break;
      case 4:
        Navigator.of(context).pushReplacementNamed(ProfileOptionsScreen.routeName);
        break;
    }
  }
}
