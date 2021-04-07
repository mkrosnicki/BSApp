import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/screens/deals/deal_item_image_section.dart';
import 'package:BSApp/screens/deals/deal_item_info_section.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      color: Colors.white,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 40,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: DealItemImageSection(widget.deal.id),
                    ),
                  ),
                  Consumer<Auth>(
                    builder: (context, authData, child) => Flexible(
                      flex: 60,
                      child: DealItemInfoSection(widget.deal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
