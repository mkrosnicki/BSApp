import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/util/date_util.dart';
import 'package:flutter/material.dart';

class DealDetailsTitlePriceSection extends StatelessWidget {
  final DealModel deal;

  const DealDetailsTitlePriceSection(this.deal);

  @override
  Widget build(BuildContext context) {
    final bool isExpired = deal.isExpired;
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
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: isExpired
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
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
              '${deal.priceString} ',
              style: TextStyle(
                  color: Colors.blue.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: isExpired
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            if (deal.dealType == DealType.OCCASION && deal.regularPrice != null)
              Text(
                '${deal.regularPrice.toStringAsFixed(2)} zł',
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              ),
          ],
        ),
      ],
    );
  }
}
