import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/my_info.dart';
import 'package:BSApp/providers/notifications.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/screens/deals/deals_screen.dart';
import 'package:BSApp/screens/initialization/init.dart';
import 'package:BSApp/screens/notifications/notifications_screen.dart';
import 'package:BSApp/screens/profile/your_profile_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deals/add_deal_screen.dart';
import 'favourites/favourites_screen.dart';
import 'forum/forum_screen.dart';
import 'initialization/initialization_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isInitialized = false;
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    DealsScreen(),
    ForumScreen(),
    AddDealScreen(),
    NotificationsScreen(),
    FavouritesScreen(),
    YourProfileScreen(),
  ];

  void _onItemTapped(int index) {
    final addDealScreenIndex = 2;
    if (!_isAuthenticated() && index == addDealScreenIndex) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  bool _isAuthenticated() {
    return Provider.of<Auth>(context, listen: false).isAuthenticated;
  }

  Future<void> init(BuildContext context) async {
    if (!_isInitialized) {
      await Init.initialize(context);
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return _isInitialized
        ? Scaffold(
            body: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
                ),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: MyColorsProvider.DEEP_BLUE,
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      CupertinoIcons.rectangle_stack,
                      size: 20,
                    ),
                    // activeIcon: Icon(Icons.home),
                  ),
                  const BottomNavigationBarItem(
                    label: '',
                    icon: Icon(CupertinoIcons.bubble_left, size: 20),
                  ),
                  const BottomNavigationBarItem(
                    label: '',
                    icon: Icon(CupertinoIcons.add, size: 20),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: Consumer<Notifications>(
                      builder: (context, notificationsData, child) => Stack(
                        children: [
                          const Icon(CupertinoIcons.bell, size: 21),
                          if (notificationsData.areNewNotifications) Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 12.0),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const BottomNavigationBarItem(
                    label: '',
                    icon: Icon(CupertinoIcons.suit_heart, size: 20),
                  ),
                  const BottomNavigationBarItem(
                    label: '',
                    icon: Icon(
                      CupertinoIcons.person,
                      size: 22,
                    ),
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          )
        : InitializationScreen();
  }
}
