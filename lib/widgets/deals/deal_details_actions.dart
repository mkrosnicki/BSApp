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
      padding: const EdgeInsets.only(top: 2.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: const Text(
              'Ocena',
              style:
              TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          DealRateBar(deal.id, true),
        ],
      ),
    );
  }
}
