import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/favourites/observed_deals_view.dart';
import 'package:BSApp/widgets/favourites/observed_searches_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/favourites';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    _scrollViewController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.square(0.0),
        child: AppBar(
          backgroundColor: Colors.blue.shade300,
          elevation: 0.0,
          brightness: Brightness.light,
          backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white),
        ),
      ),
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text(
                'Ulubione',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              pinned: true,
              floating: true,
              centerTitle: true,
              expandedHeight: 80.0,
              // collapsedHeight: 15.0,
              backgroundColor: Colors.white,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.all(10.0),
                indicatorColor: MyColorsProvider.DEEP_BLUE,
                labelColor: Colors.black,
                labelStyle: MyStylingProvider.SELECTED_TAB_TEXT_STYLE,
                unselectedLabelStyle:
                    MyStylingProvider.UNSELECTED_TAB_TEXT_STYLE,
                tabs: const [
                  Text('Okazje'),
                  Text('Wyszukiwania'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ObservedDealsView(),
            ObservedSearchesView(),
          ],
        ),
      ),
    );
  }
}
