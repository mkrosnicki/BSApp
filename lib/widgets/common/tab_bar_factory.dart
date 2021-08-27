import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

import 'default_tab.dart';

class TabBarFactory {

  static TabBar withTabs(final List<String> tabNames) {
    return TabBar(
      labelPadding: EdgeInsets.zero,
      indicatorColor: MyColorsProvider.BLUE,
      indicatorSize: TabBarIndicatorSize.tab,
      overlayColor: MaterialStateProperty.all(MyColorsProvider.DEEP_BLUE),
      unselectedLabelColor: Colors.grey[500],
      labelColor: Colors.black,
      labelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      tabs: tabNames.map((tabName) => DefaultTab(tabName)).toList(),
    );
  }

}