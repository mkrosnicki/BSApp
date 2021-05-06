import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/deals/deal_item_heart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsImage extends StatelessWidget {
  final DealModel deal;

  const DealDetailsImage(this.deal);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.35;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: imageHeight + 20,
          width: double.infinity,
        ),
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: deal.image ?? Image.network(
            'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                  color: MyColorsProvider.GREY_BORDER_COLOR, width: 0.5),
            ),
            child: DealItemHeartButton(deal, 30),
          ),
        ),
      ],
    );
  }

  void _toggleFavourites(BuildContext context, String dealId, bool isFavourite, bool isUserLoggedIn) {
    if (!isUserLoggedIn) {
      AuthScreenProvider.showLoginScreen(context);
    } else if (isFavourite) {
      Provider.of<Deals>(context, listen: false)
          .removeFromObservedDeals(dealId);
    } else {
      Provider.of<Deals>(context, listen: false).addToObservedDeals(dealId);
    }
  }
}
