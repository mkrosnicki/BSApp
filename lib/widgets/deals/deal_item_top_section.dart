import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealItemTopSection extends StatelessWidget {
  final DealModel deal;

  DealItemTopSection(this.deal);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Flex(
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
                      child: Consumer<Deals>(
                        builder: (context, dealsData, child) {
                          return GestureDetector(
                            onTap: () => _toggleFavourites(
                                context,
                                deal,
                                dealsData.isObservedDeal(deal),
                                authData.isAuthenticated),
                            child: dealsData.isObservedDeal(deal)
                                ? Icon(CupertinoIcons.heart_fill, size: 20)
                                : Icon(CupertinoIcons.heart, size: 20),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Text(
                '${deal.currentPrice.toString()} zł ',
                style: TextStyle(
                    color: Colors.blue.shade500,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '${deal.regularPrice} zł',
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough),
              ),
            ],
          )
        ],
      ),
    );
  }

  _toggleFavourites(BuildContext context, DealModel deal, bool isFavourite,
      bool isUserLoggedIn) {
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else if (isFavourite) {
      Provider.of<Deals>(context, listen: false)
          .deleteFromObservedDeals(deal.id);
    } else {
      Provider.of<Deals>(context, listen: false).addToObservedDeals(deal.id);
    }
  }
}
