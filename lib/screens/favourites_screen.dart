import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/deal_item.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
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
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Obserwowane'),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                labelPadding: const EdgeInsets.all(10.0),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
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
            return TabBarView(
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
                                child: Text('An error occurred!'),
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
                      Text('Wyszukiwania'),
                    ]
                  : [
                      _buildNoObservedDealsSplashView(),
                      _buildNoObservedSearchesSplashView(),
                    ],
            );
          },
        ),
      ),
      bottomNavigationBar: MyNavigationBar(2),
    );
  }

  _buildNoObservedDealsSplashView() {
    return const Center(
      child: Text('Nie obserwujesz żadnych okazji!'),
    );
  }

  _buildNoObservedSearchesSplashView() {
    return const Center(
      child: Text('Nie obserwujesz żadnych wyszukiwań!'),
    );
  }
}
