import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/colored_tab.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:flutter/material.dart';

class AppBarAddDeal extends StatefulWidget implements PreferredSizeWidget {
  static const Size _aPreferredSize = Size.fromHeight(85.0);

  @override
  _AppBarAddDealState createState() => _AppBarAddDealState();

  @override
  Size get preferredSize => AppBarAddDeal._aPreferredSize;
}

class _AppBarAddDealState extends State<AppBarAddDeal> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      title: 'Dodaj nową okazję',
      leading: const AppBarBackButton(Colors.white),
      bottom: DecoratedTabBar(
        tabBar: TabBar(
          labelPadding: EdgeInsets.zero,
          indicatorColor: MyColorsProvider.PASTEL_LIGHT_BLUE,
          labelColor: Colors.white,
          labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
          unselectedLabelStyle: MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: [
            ColoredTab('Okazja', _selectedIndex == 0),
            ColoredTab('Kupon', _selectedIndex == 1),
          ],
        ),
      ),
    );
  }
}
