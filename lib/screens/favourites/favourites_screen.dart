import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
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
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(85.0),
          child: BaseAppBar(
            title: 'Ulubione',
            bottom: DecoratedTabBar(
              tabBar: TabBar(
                labelPadding: EdgeInsets.all(10.0),
                indicatorColor: MyColorsProvider.DEEP_BLUE,
                labelColor: Colors.black,
                labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
                unselectedLabelStyle: MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
                tabs: [
                  Text('Okazje'),
                  Text('Wyszukiwania'),
                ],
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
