import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/error_info.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:BSApp/widgets/searches/observed_search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _scrollViewController = new ScrollController();
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
        preferredSize: Size.square(0.0),
        child: AppBar(
          backgroundColor: Colors.blue.shade300,
        ),
      ),
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Obserwowane', style: TextStyle(color: Colors.black, fontSize: 18),),
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
                indicatorColor: MyColorsProvider.BLUE,
                labelColor: Colors.black,
                labelStyle: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 12),
                tabs: [
                  Text('Okazje'),
                  Text('Wyszukiwania'),
                ],
              ),
            ),
          ];
        },
        body: Consumer<Auth>(
          builder: (context, auth, child) {
            return Container(
              child: TabBarView(
                controller: _tabController,
                children: auth.isAuthenticated
                    ? [
                        FutureBuilder(
                          future: Provider.of<Deals>(context, listen: false)
                              .fetchObservedDeals(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot.error != null) {
                                return Center(
                                  child: const ServerErrorSplash(),
                                );
                              } else {
                                return Consumer<Deals>(
                                  builder: (context, dealsData, child) {
                                    return dealsData.observedDeals.isNotEmpty
                                        ? ListView.builder(
                                            itemBuilder: (context, index) =>
                                                Column(
                                              children: [
                                                DealItem(dealsData
                                                    .observedDeals[index]),
                                                DealItem(dealsData
                                                    .observedDeals[index]),
                                                DealItem(dealsData
                                                    .observedDeals[index]),
                                              ],
                                            ),
                                            itemCount:
                                                dealsData.observedDeals.length,
                                          )
                                        : _buildNoObservedDealsSplashView();
                                  },
                                );
                              }
                            }
                          },
                        ),
                        FutureBuilder(
                          future: Provider.of<Searches>(context, listen: false)
                              .fetchSavedSearches(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              if (snapshot.error != null) {
                                return ErrorInfo();
                              } else {
                                return Consumer<Searches>(
                                  builder: (context, searchesData, child) {
                                    return searchesData.savedSearches.isNotEmpty
                                        ? ListView.builder(
                                            itemBuilder: (context, index) =>
                                                ObservedSearchItem(searchesData
                                                    .savedSearches[index]),
                                            itemCount:
                                                searchesData.savedSearches.length,
                                          )
                                        : _buildNoObservedSearchesSplashView();
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ]
                    : [
                        _buildNoObservedDealsSplashView(),
                        _buildNoObservedSearchesSplashView(),
                      ],
              ),
            );
          },
        ),
      ),
    );
  }

  _buildNoObservedDealsSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: const Text(
          'Nie obserwujesz żadnych okazji',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }

  _buildNoObservedSearchesSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: const Text(
          'Nie obserwujesz \nżadnych wyszukiwań',
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
