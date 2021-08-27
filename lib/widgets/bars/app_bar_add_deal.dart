import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/colored_tab.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:BSApp/widgets/common/tab_bar_factory.dart';
import 'package:flutter/material.dart';

class AppBarAddDeal extends StatefulWidget implements PreferredSizeWidget {
  static const Size _aPreferredSize = Size.fromHeight(96.0);

  const AppBarAddDeal();

  @override
  _AppBarAddDealState createState() => _AppBarAddDealState();

  @override
  Size get preferredSize => AppBarAddDeal._aPreferredSize;
}

class _AppBarAddDealState extends State<AppBarAddDeal> {

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      title: 'Dodaj nową okazję',
      leading: const AppBarBackButton(Colors.white),
      bottom: DecoratedTabBar(
        decoration: MyStylingProvider.DEFAULT_TAB_BAR_DECORATION,
        tabBar: TabBarFactory.withTabs(
          ['Okazja', 'Kupon'],
        ),
      ),
    );
  }
}
