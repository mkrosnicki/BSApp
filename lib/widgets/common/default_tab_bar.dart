import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/material.dart';

import 'default_tab.dart';

class DefaultTabBar extends StatelessWidget {
  final List<String> tabNames;

  const DefaultTabBar(this.tabNames);

  @override
  Widget build(BuildContext context) {
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
