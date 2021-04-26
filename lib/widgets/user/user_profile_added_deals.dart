import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';

class UserProfileAddedDeals extends StatelessWidget {
  final List<DealModel> addedDeals;

  UserProfileAddedDeals(this.addedDeals);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: addedDeals.length,
        itemBuilder: (context, index) {
          return DealItem(addedDeals[index]);
        },
      ),
    );
  }
}
