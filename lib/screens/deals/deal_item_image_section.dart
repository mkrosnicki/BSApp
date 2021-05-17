import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deal_details_screen.dart';

class DealItemImageSection extends StatelessWidget {
  final DealModel deal;

  const DealItemImageSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
      },
      child: Stack(
        children: [
          const SizedBox(
            height: 130,
            width: double.infinity,
          ),
          Container(
            height: 130,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
              ),
              child: deal.image ??
                  Image.network(
                    'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          if (!_willBeValidLongerThanOneDay()) Positioned(
            bottom: 0.0,
            left: 0.0,
            child: Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey),
                color: Colors.black26,
              ),
              constraints: const BoxConstraints(
                minHeight: 22,
              ),
              child: Center(
                child: Text(_isExpired() ? 'Wygasła' : 'Niedługo wygasa', style: const TextStyle(fontSize: 10, color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _willBeValidLongerThanOneDay() {
    return deal.endDate == null && DateTime.now().difference(deal.endDate).inDays > 1;
  }

  bool _isExpired() {
    return deal.endDate != null && DateTime.now().isAfter(deal.endDate);
  }

  bool _isNearExpiry() {
    return deal.endDate != null && DateTime.now().difference(deal.endDate).inDays <= 1;
  }
}
