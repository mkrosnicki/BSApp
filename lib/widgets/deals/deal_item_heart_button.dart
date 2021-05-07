import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/current_user.dart';
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
      builder: (context, authData, child) => Consumer<CurrentUser>(
        builder: (context, dealsData, child) {
          final bool isObservedDeal = dealsData.isObservedDeal(deal);
          return GestureDetector(
            onTap: () => _toggleFavourites(
                context, deal, isObservedDeal, authData.isAuthenticated),
            child: isObservedDeal
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
    final currentUserProvider =
        Provider.of<CurrentUser>(context, listen: false);
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else if (isFavourite) {
      currentUserProvider.removeFromObservedDeals(deal.id);
    } else {
      currentUserProvider.addToObservedDeals(deal.id);
    }
  }
}
