import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
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
      child: Flex(
        direction: Axis.vertical,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          fit: StackFit.loose,
                          children: [
                            Container(
                              height: 130,
                              width: double.infinity,
                            ),
                            Container(
                              height: 130,
                              width: double.infinity,
                              child: Image.network(
                                'https://cdn.arena.pl/7101c435b57786e6e21cb7939e95263f-product_lightbox.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              padding: new EdgeInsets.only(
                                  top: 95.0, right: 0.0, left: 0.0),
                              child: new Container(
                                height: 35.0,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(CupertinoIcons.hand_thumbsdown, size: 18.0, color: Colors.white,),
                                      Text('2', style: TextStyle(color: Colors.white)),
                                      Icon(CupertinoIcons.hand_thumbsup, size: 18.0, color: Colors.white,),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   right: 2.0,
                            //   bottom: 0,
                            //   child: Container(
                            //     clipBehavior: Clip.hardEdge,
                            //     padding: EdgeInsets.all(4.0),
                            //     // color: Theme.of(context).accentColor,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(20.0),
                            //       border: Border.all(color: Colors.grey),
                            //       color: Colors.black26,
                            //     ),
                            //     constraints: BoxConstraints(
                            //       minWidth: 100,
                            //       minHeight: 14,
                            //     ),
                            //     child: Center(child: Icon(CupertinoIcons.hand_thumbsup, size: 18.0, color: Colors.white,),),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 65,
                    child: Container(
                      height: 120,
                      child: Padding(
                        padding: EdgeInsets.only(left: 14.0),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flex(
                              direction: Axis.vertical,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(
                                              DealDetailsScreen.routeName,
                                              arguments: deal.id),
                                      child: Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        direction: Axis.horizontal,
                                        children: [
                                          Flexible(
                                            flex: 8,
                                            child: Text(
                                              deal.title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              // overflow: TextOverflow.ellipsis,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Consumer<Auth>(
                                              builder:
                                                  (context, authData, child) =>
                                                      Consumer<Deals>(
                                                builder: (context, dealsData,
                                                    child) {
                                                  return GestureDetector(
                                                    onTap: () =>
                                                        _toggleFavourites(
                                                            context,
                                                            deal,
                                                            dealsData
                                                                .isObservedDeal(
                                                                    deal),
                                                            authData
                                                                .isAuthenticated),
                                                    child: dealsData
                                                            .isObservedDeal(
                                                                deal)
                                                        ? Icon(Icons.favorite)
                                                        : Icon(Icons
                                                            .favorite_border),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('${deal.regularPrice.toString()} zł'),
                                    // Padding(
                                    //     padding: EdgeInsets.all(4.0),
                                    //     child: Text('•')),
                                    Text(
                                      '${deal.currentPrice.toString()} zł',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Padding(
                                    //     padding: EdgeInsets.all(4.0),
                                    //     child: Text('•')),
                                    Text('(${deal.discountString})'),
                                  ],
                                )
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     // Text('${deal.regularPrice.toString()} zł'),
                            //     // Padding(
                            //     //     padding: EdgeInsets.all(4.0),
                            //     //     child: Text('•')),
                            //     Text(
                            //       '${deal.currentPrice.toString()} zł',
                            //       style: TextStyle(
                            //           color: Colors.blue,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //     Padding(
                            //         padding: EdgeInsets.all(4.0),
                            //         child: Text('•')),
                            //     Text('(${deal.discountString})'),
                            //   ],
                            // ),
                            // GestureDetector(
                            //   onTap: () => _navigateToUserProfileScreen(context),
                            //   child: Text(
                            //     deal.addedByUsername,
                            //     style: TextStyle(color: Colors.blue),
                            //   ),
                            // ),
                            Flex(
                              direction: Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lokalizacja: Internet',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Dodana: ${deal.addedAt.toUtc()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              CupertinoIcons.hand_thumbsup,
                                              size: 16,
                                            ),
                                            Text('23'),
                                            Icon(
                                              CupertinoIcons.hand_thumbsup,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Text('Sprawdź'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Flex(
          //   direction: Axis.horizontal,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Flexible(
          //       flex: 35,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Icon(
          //             CupertinoIcons.hand_thumbsup,
          //             size: 16,
          //           ),
          //           Text('2'),
          //           Icon(
          //             CupertinoIcons.hand_thumbsup,
          //             size: 16,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Flexible(
          //       flex: 65,
          //       child: Text('a'),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  _navigateToUserProfileScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(UserProfileScreen.routeName, arguments: deal.addedById);
  }

  _toggleFavourites(BuildContext context, DealModel deal, bool isFavourite,
      bool isUserLoggedIn) {
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
