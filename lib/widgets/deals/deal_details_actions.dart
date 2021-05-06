import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/widgets/deals/deal_rate_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealDetailsActions extends StatelessWidget {
  final DealModel deal;

  const DealDetailsActions(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Divider(),
          DealRateBar(deal),
        ],
      ),
    );
  }
}
