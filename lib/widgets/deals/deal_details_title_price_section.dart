import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class DealDetailsTitlePriceSection extends StatelessWidget {

  final DealModel deal;

  const DealDetailsTitlePriceSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              Flexible(
                flex: 8,
                child: Text(
                  deal.title,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(
                  DateUtil.timeAgoString(deal.addedAt),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
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
      ],
    );
  }
}
