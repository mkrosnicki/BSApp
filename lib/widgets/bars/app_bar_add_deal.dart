import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:flutter/material.dart';

class AppBarAddDeal extends StatelessWidget implements PreferredSizeWidget {
  static const Size _aPreferredSize = Size.fromHeight(85.0);

  @override
  Widget build(BuildContext context) {
    return const BaseAppBar(
      title: 'Dodaj nową okazję',
      leading: AppBarBackButton(Colors.black),
      bottom: DecoratedTabBar(
        tabBar: TabBar(
            labelPadding: EdgeInsets.all(10.0),
            indicatorColor: MyColorsProvider.DEEP_BLUE,
            labelColor: Colors.black,
            labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
            unselectedLabelStyle: MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
            tabs: [
              Text('Okazja'),
              Text('Kupon'),
            ]),
      ),
    );
  }

  @override
  Size get preferredSize => _aPreferredSize;
}
