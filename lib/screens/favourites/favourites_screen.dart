import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/colored_tab.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:BSApp/widgets/common/tab_bar_factory.dart';
import 'package:BSApp/widgets/favourites/observed_deals_view.dart';
import 'package:BSApp/widgets/favourites/observed_searches_view.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/favourites';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(96.0),
          child: BaseAppBar(
            title: 'Ulubione',
            bottom: DecoratedTabBar(
              decoration: MyStylingProvider.DEFAULT_TAB_BAR_DECORATION,
              tabBar: TabBarFactory.withTabs(
                ['Okazje', 'Wyszukiwania'],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ObservedDealsView(),
            ObservedSearchesView(),
          ],
        ),
      ),
    );
  }
}
