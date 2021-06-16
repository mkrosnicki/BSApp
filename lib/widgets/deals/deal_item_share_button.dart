import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/services/dynamic_link_service.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class DealItemShareButton extends StatelessWidget {
  final DealModel deal;
  final double iconSize;

  const DealItemShareButton(this.deal, this.iconSize);

  @override
  Widget build(BuildContext context) {
    final DynamicLinkService dynamicLinkService = DynamicLinkService();
    return FutureBuilder<Uri>(
        future: dynamicLinkService.createDynamicLink(deal.id),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            Uri uri = snapshot.data;
            return GestureDetector(
              onTap: () => Share.share(uri.toString()),
              child: Icon(CupertinoIcons.share, size: iconSize, color: MyColorsProvider.LIGHT_RED_SHADY),
            );
          } else {
            return Container();
          }

        }
    );
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        final bool isObservedDeal = currentUser.observesDeal(deal);
        return GestureDetector(
          onTap: () => _toggleFavourites(
              context, deal, isObservedDeal, currentUser.isAuthenticated),
          child: isObservedDeal
              ? Icon(CupertinoIcons.share,
              size: iconSize, color: MyColorsProvider.LIGHT_RED_SHADY)
              : Icon(CupertinoIcons.heart_fill,
              size: iconSize, color: MyColorsProvider.LIGHT_GRAY),
        );
      },
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
