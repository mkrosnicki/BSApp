import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/models/deal_screen_arguments.dart';
import 'package:BSApp/models/deal_type.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/widgets/deals/deal_item_heart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealItemTopSection extends StatelessWidget {
  final DealModel deal;

  const DealItemTopSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(DealDetailsScreen.routeName, arguments: deal),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 8,
                    child: Text(
                      deal.title,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: DealItemHeartButton(deal, 20),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '${deal.priceString} ',
              style: TextStyle(
                  color: Colors.blue.shade500,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            if (deal.dealType == DealType.OCCASION && deal.regularPrice != null) Text(
              '${deal.regularPrice} zł',
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough),
            ),
          ],
        )
      ],
    );
  }
}
