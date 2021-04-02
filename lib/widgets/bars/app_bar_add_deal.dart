import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/material.dart';

import 'app_bar_bottom_border.dart';

class AppBarAddDeal extends StatelessWidget implements PreferredSizeWidget {
  static const Size _aPreferredSize = Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Dodaj nową okazję',
        style: MyStylingProvider.TEXT_BLACK,
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      bottom: TabBar(
          indicatorWeight: 3.0,
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            _buildTabBar('Okazja'),
            _buildTabBar('Kupon'),
          ]),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => _aPreferredSize;

  _buildTabBar(String label) {
    return Tab(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              // decoration: BoxDecoration(
              //     border: Border(
              //         bottom: BorderSide(color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5))),
              // padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
              child: Center(
                  child: Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
