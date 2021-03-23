import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealItem extends StatelessWidget {
  final DealModel deal;

  DealItem(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 35,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          DealDetailsScreen.routeName,
                          arguments: deal.id);
                    },
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Image.network(
                            'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            // color: Theme.of(context).accentColor,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme
                                  .of(context)
                                  .accentColor,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              'value',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(
                                  DealDetailsScreen.routeName,
                                  arguments: deal.id),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  flex: 8,
                                  child: Text(
                                    deal.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    // overflow: TextOverflow.clip,
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Consumer<Auth>(
                                    builder: (context, authData, child) => Consumer<Deals>(
                                      builder: (context, dealsData, child) {
                                        return GestureDetector(
                                          onTap: () => _toggleFavourites(context, deal, dealsData.isObservedDeal(deal), authData.isAuthenticated),
                                          child: dealsData.isObservedDeal(deal) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text('${deal.regularPrice.toString()} zł'),
                            Padding(
                                padding: EdgeInsets.all(4.0), child: Text('•')),
                            Text('${deal.currentPrice.toString()} zł'),
                            Padding(
                                padding: EdgeInsets.all(4.0), child: Text('•')),
                            Text(deal.discountString),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _navigateToUserProfileScreen(context),
                          child: Text(
                            deal.addedByUsername,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        Text(deal.description),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _navigateToUserProfileScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: deal.addedById);
  }

  _toggleFavourites(BuildContext context, DealModel deal, bool isFavourite, bool isUserLoggedIn) {
    if (!isUserLoggedIn) {
      _showLoginScreen(context);
    } else if (isFavourite) {
      Provider.of<Deals>(context, listen: false)
          .deleteFromObservedDeals(deal.id);
    } else {
      Provider.of<Deals>(context, listen: false).addToObservedDeals(deal.id);
    }
  }

  _showLoginScreen(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoginRegistrationScreen();
        },
        fullscreenDialog: true));
  }
}
