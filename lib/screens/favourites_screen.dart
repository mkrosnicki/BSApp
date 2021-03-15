import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/deal_item.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourites';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ulubione'),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 40),
            child: Material(
              color: Colors.transparent,
              child: TabBar(
                labelPadding: const EdgeInsets.all(10.0),
                indicatorColor: Colors.white,
                labelColor: Colors.white,
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
            SafeArea(
              child: FutureBuilder(
                future: Provider.of<Deals>(context, listen: false)
                    .fetchFavouriteDeals(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text('An error occurred!'),
                      );
                    } else {
                      return Consumer<Deals>(
                        builder: (context, dealsData, child) =>
                            ListView.builder(
                          itemBuilder: (context, index) => Column(
                            children: [
                              DealItem(dealsData.deals[index]),
                              DealItem(dealsData.deals[index]),
                              DealItem(dealsData.deals[index]),
                            ],
                          ),
                          itemCount: dealsData.deals.length,
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            Text('gfdsgfdgfd'),
          ],
        ),
        bottomNavigationBar: MyNavigationBar(2),
      ),
    );
  }
}
