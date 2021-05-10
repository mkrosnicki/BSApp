import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:dotted_border/dotted_border.dart';
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
                fontSize: 16,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${deal.regularPrice} zł',
                style: const TextStyle(
                    fontSize: 15,
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
                  child: const Text(
                    'Opis',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(deal.description),
              ],
            ),
          ),
          if (deal.code != null)
            Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: const Text(
              'Kod rabatowy',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          if (deal.code != null)
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              width: double.infinity,
              child: DottedBorder(
                color: MyColorsProvider.LIGHT_GRAY,
                // color: Colors.deepOrange,
                strokeWidth: 2,
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 12.0),
                dashPattern: const [5, 5],
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      deal.code,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
