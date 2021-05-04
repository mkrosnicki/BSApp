import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/bars/app_bar_back_button.dart';
import 'package:BSApp/widgets/bars/base_app_bar.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddedDealsScreen extends StatelessWidget {
  static const routeName = '/added-deals';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: const AppBarBackButton(Colors.black),
        title: 'Dodane okazje',
      ),
      body: FutureBuilder(
        future: Provider.of<Deals>(context, listen: false).fetchDeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(
                child: const ServerErrorSplash(),
              );
            } else {
              return Consumer<Deals>(
                builder: (context, dealsData, child) => ListView.builder(
                  itemBuilder: (context, index) =>
                      DealItem(dealsData.addedDeals[index]),
                  itemCount: dealsData.addedDeals.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
