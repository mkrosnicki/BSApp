import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:BSApp/widgets/deals/deal_item_image_section.dart';
import 'package:BSApp/widgets/deals/deal_item_info_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DealItem extends StatelessWidget {
  final DealModel deal;

  const DealItem(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MyStylingProvider.ITEMS_MARGIN,
      decoration: MyStylingProvider.ITEMS_BORDER.copyWith(color: Colors.white),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 35,
            child: Align(
              alignment: Alignment.topLeft,
              child: DealItemImageSection(deal),
            ),
          ),
          Flexible(
            flex: 65,
            child: DealItemInfoSection(deal),
          ),
        ],
      ),
    );
  }
}
