import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';

class DealDetailsDescription extends StatelessWidget {

  final DealModel deal;

  const DealDetailsDescription(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              deal.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                '${deal.currentPrice.toString()} zł ',
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${deal.regularPrice} zł',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('Opis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                ),
                Text(deal.description),
              ],
            ),
          )        ],
      ),
    );
  }
}
