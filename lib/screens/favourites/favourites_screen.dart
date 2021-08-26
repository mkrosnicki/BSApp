import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/colored_tab.dart';
import 'package:BSApp/widgets/common/decorated_tab_bar.dart';
import 'package:BSApp/widgets/favourites/observed_deals_view.dart';
import 'package:BSApp/widgets/favourites/observed_searches_view.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/favourites';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> with TickerProviderStateMixin{

  int _selectedIndex = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
        _tabController.animateTo(_selectedIndex, duration: Duration.zero);
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: BaseAppBar(
          title: 'Ulubione',
          bottom: DecoratedTabBar(
            tabBar: TabBar(
              controller: _tabController,
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
                ColoredTab('Okazje', _selectedIndex == 0),
                ColoredTab('Wyszukiwania', _selectedIndex == 1),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ObservedDealsView(),
          ObservedSearchesView(),
        ],
      ),
    );
  }
}
