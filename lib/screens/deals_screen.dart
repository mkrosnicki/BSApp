import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/deal_item.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealsScreen extends StatelessWidget {
  static const routeName = '/deals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deals'),
      ),
      body: FutureBuilder(
        future: Provider.of<Deals>(context, listen: false).fetchDeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _refreshDeals(context),
                child: Consumer<Deals>(
                  builder: (context, dealsData, child) => ListView.builder(
                    itemBuilder: (context, index) =>
                        DealItem(dealsData.deals[index]),
                    itemCount: dealsData.deals.length,
                  ),
                ),
              );
            }
          }
        },
      ),
      bottomNavigationBar: MyNavigationBar(0),
    );
  }

  Future<void> _refreshDeals(BuildContext context) async {
    await Provider.of<Deals>(context, listen: false).fetchDeals();
  }
}
