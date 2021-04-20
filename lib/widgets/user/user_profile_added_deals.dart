import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileAddedDeals extends StatelessWidget {

  String userId;

  UserProfileAddedDeals(this.userId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Deals>(context, listen: false)
          .fetchDealsAddedBy(userId),
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
              builder: (context, userDealsData, child) => Column(
                children: userDealsData.fetchedUserAddedDeals
                    .map((deal) => DealItem(deal))
                    .toList(),
              ),
            );
          }
        }
      },
    );
  }
}
