import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealItemImageSection extends StatelessWidget {
  final DealModel deal;

  const DealItemImageSection(this.deal);

  @override
  Widget build(BuildContext context) {
    const double imageHeight = 130.0;
    const double minIndicatorHeight = 22.0;
    final Image image = Provider.of<Deals>(context, listen: false).getImageById(deal.id);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context)
            .pushNamed(DealDetailsScreen.routeName, arguments: deal);
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
              child: image ??
                  (deal.imagePath != null
                      ? Image.network(
                          deal.imagePath,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
                          fit: BoxFit.cover,
                        )),
            ),
          ),
          if (!_willBeValidLongerThanOneDay())
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                bottomLeft: Radius.circular(4.0),
              ),
              child: Container(
                margin: const EdgeInsets.only(
                    top: imageHeight - minIndicatorHeight),
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                color: Colors.black26,
                constraints: const BoxConstraints(
                  minHeight: minIndicatorHeight,
                ),
                child: Center(
                  child: Text(
                    _isExpired()
                        ? 'Wygasła'
                        : 'Wygasa za ${_expiresInHours()}h',
                    style: const TextStyle(fontSize: 11, color: Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool _willBeValidLongerThanOneDay() {
    return deal.endDate == null || _expiresInHours() > 24;
  }

  bool _isExpired() {
    return deal.endDate != null && DateTime.now().isAfter(deal.endDate);
  }

  // todo handle minutes, seconds, ...
  int _expiresInHours() {
    return deal.endDate.difference(DateTime.now()).inHours;
  }

  bool _isNearExpiry() {
    return deal.endDate != null &&
        DateTime.now().difference(deal.endDate).inHours <= 24;
  }
}
