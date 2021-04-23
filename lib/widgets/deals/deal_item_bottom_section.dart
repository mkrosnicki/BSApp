import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/widgets/deals/deal_rate_bar.dart';
import 'package:flutter/material.dart';

class DealItemBottomSection extends StatelessWidget {
  final DealModel deal;

  DealItemBottomSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: DealRateBar(deal),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                'ZOBACZ',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
