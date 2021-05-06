import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/material.dart';

class DealCreatedActivityContent extends StatelessWidget {
  final String username;
  final DealModel deal;

  const DealCreatedActivityContent(this.username, this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$username dodał(a) okazję',
            style: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.2),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              deal.title,
              style:
              const TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
