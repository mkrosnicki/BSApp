import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';

class DealDetailsDescription extends StatelessWidget {

  final DealModel deal;

  DealDetailsDescription(this.deal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            deal.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(deal.dealType.toString()),
              Text(deal.categories.last),
              Text(deal.regularPrice.toString()),
              Row(
                children: [
                  Text('${deal.currentPrice.toString()} zł'),
                  Padding(padding: EdgeInsets.all(4.0), child: Text('•')),
                  Text(deal.discountString),
                ],
              ),
              Text(deal.description),
            ],
          ),
        )
      ],
    );
  }
}
