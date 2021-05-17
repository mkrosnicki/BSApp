import 'package:BSApp/models/deal_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'deal_details_screen.dart';

class DealItemImageSection extends StatelessWidget {
  final DealModel deal;

  const DealItemImageSection(this.deal);

  @override
  Widget build(BuildContext context) {

    const double imageHeight = 130.0;
    const double minIndicatorHeight = 22.0;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal);
      },
      child: Stack(
        children: [
          const SizedBox(
            height: imageHeight,
            width: double.infinity,
          ),
          Container(
            height: imageHeight,
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
          if (!_willBeValidLongerThanOneDay()) ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: imageHeight - minIndicatorHeight),
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
              color: Colors.black26,
              constraints: const BoxConstraints(
                minHeight: minIndicatorHeight,
              ),
              child: Center(
                child: Text(_isExpired() ? 'Wygasła' : 'Niedługo wygasa', style: const TextStyle(fontSize: 11, color: Colors.white),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _willBeValidLongerThanOneDay() {
    return deal.endDate == null || deal.endDate.difference(DateTime.now()).inDays > 1;
  }

  bool _isExpired() {
    return deal.endDate != null && DateTime.now().isAfter(deal.endDate);
  }

  bool _isNearExpiry() {
    return deal.endDate != null && DateTime.now().difference(deal.endDate).inDays <= 1;
  }
}
