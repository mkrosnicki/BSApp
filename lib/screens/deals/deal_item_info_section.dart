import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/widgets/deals/deal_item_bottom_section.dart';
import 'package:BSApp/widgets/deals/deal_item_middle_section.dart';
import 'package:BSApp/widgets/deals/deal_item_top_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealItemInfoSection extends StatelessWidget {
  final DealModel deal;

  const DealItemInfoSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding:
          const EdgeInsets.only(left: 14.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DealItemTopSection(deal),
          DealItemMiddleSection(deal),
          DealItemBottomSection(deal),
        ],
      ),
    );
  }
}
