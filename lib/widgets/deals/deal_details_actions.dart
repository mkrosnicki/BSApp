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
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 16.0, bottom: 10.0),
            child: const Text(
              'Ocena',
              style:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          DealRateBar(deal.id),
        ],
      ),
    );
  }
}
