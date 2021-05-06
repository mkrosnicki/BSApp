import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealItemHeartButton extends StatelessWidget {
  final DealModel deal;
  final double iconSize;

  const DealItemHeartButton(this.deal, this.iconSize);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Deals>(
        builder: (context, dealsData, child) {
          return GestureDetector(
            onTap: () => _toggleFavourites(context, deal,
                dealsData.isObservedDeal(deal), authData.isAuthenticated),
            child: dealsData.isObservedDeal(deal)
                ? Icon(CupertinoIcons.heart_fill,
                    size: iconSize, color: MyColorsProvider.LIGHT_RED_SHADY)
                : Icon(CupertinoIcons.heart_fill,
                    size: iconSize, color: MyColorsProvider.LIGHT_GRAY),
          );
        },
      ),
    );
  }

  void _toggleFavourites(BuildContext context, DealModel deal, bool isFavourite,
      bool isUserLoggedIn) {
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else if (isFavourite) {
      Provider.of<Deals>(context, listen: false)
          .removeFromObservedDeals(deal.id);
    } else {
      Provider.of<Deals>(context, listen: false).addToObservedDeals(deal.id);
    }
  }
}
