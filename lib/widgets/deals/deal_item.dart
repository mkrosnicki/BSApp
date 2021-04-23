import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/deals/deal_item_image_section.dart';
import 'package:BSApp/screens/deals/deal_item_info_section.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealItem extends StatefulWidget {
  final DealModel deal;

  DealItem(this.deal);

  @override
  _DealItemState createState() => _DealItemState();
}

class _DealItemState extends State<DealItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        color: Colors.white,
        border: Border.all(
          color: MyColorsProvider.GREY_BORDER_COLOR,
          width: 0.2,
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 35,
            child: Align(
              alignment: Alignment.topLeft,
              child: DealItemImageSection(widget.deal),
            ),
          ),
          Flexible(
            flex: 65,
            child: DealItemInfoSection(widget.deal),
          ),
        ],
      ),
    );
  }
}
