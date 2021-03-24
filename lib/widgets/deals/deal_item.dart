import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DealItem extends StatefulWidget {
  final DealModel deal;

  DealItem(this.deal);

  @override
  _DealItemState createState() => _DealItemState();
}

class _DealItemState extends State<DealItem> {
  DateFormat _dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    _dateFormat = new DateFormat.yMMMMd('pl');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
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
                    flex: 40,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              DealDetailsScreen.routeName,
                              arguments: widget.deal.id);
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
                                      Icon(
                                        CupertinoIcons.hand_thumbsdown,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                      Text('2',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Icon(
                                        CupertinoIcons.hand_thumbsup,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 0.0,
                            //   left: 0.0,
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
                  Consumer<Auth>(
                    builder: (context, authData, child) => Flexible(
                      flex: 60,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                DealDetailsScreen.routeName,
                                                arguments: widget.deal.id),
                                        child: Flex(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          direction: Axis.horizontal,
                                          children: [
                                            Flexible(
                                              flex: 8,
                                              child: Text(
                                                widget.deal.title,
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
                                              child: Consumer<Deals>(
                                                builder: (context, dealsData,
                                                    child) {
                                                  return GestureDetector(
                                                    onTap: () =>
                                                        _toggleFavourites(
                                                            context,
                                                            widget.deal,
                                                            dealsData
                                                                .isObservedDeal(
                                                                    widget
                                                                        .deal),
                                                            authData
                                                                .isAuthenticated),
                                                    child: dealsData
                                                            .isObservedDeal(
                                                                widget.deal)
                                                        ? Icon(Icons.favorite)
                                                        : Icon(Icons
                                                            .favorite_border),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        '${widget.deal.currentPrice.toString()} zł ',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${widget.deal.regularPrice} zł',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lokalizacja: Internet',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'Dodana: ${_dateFormat.format(widget.deal.addedAt)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Consumer<Deals>(
                                          builder:
                                              (context, dealsData, child) =>
                                                  Flexible(
                                            flex: 1,
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => _vote(
                                                      authData.isAuthenticated,
                                                      false),
                                                  child: Provider.of<Deals>(
                                                              context)
                                                          .wasVotedNegativelyBy(
                                                              widget.deal.id,
                                                              authData.userId)
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .hand_thumbsdown_fill,
                                                          size: 16,
                                                        )
                                                      : Icon(
                                                          CupertinoIcons
                                                              .hand_thumbsdown,
                                                          size: 16,
                                                        ),
                                                ),
                                                Text(dealsData
                                                    .findById(widget.deal.id)
                                                    .numberOfPoints
                                                    .toString()),
                                                GestureDetector(
                                                  onTap: () => _vote(
                                                      authData.isAuthenticated,
                                                      true),
                                                  child: Provider.of<Deals>(
                                                              context)
                                                          .wasVotedPositivelyBy(
                                                              widget.deal.id,
                                                              authData.userId)
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .hand_thumbsup_fill,
                                                          size: 16,
                                                        )
                                                      : Icon(
                                                          CupertinoIcons
                                                              .hand_thumbsup,
                                                          size: 16,
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Text('ZOBACZ',
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
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
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _vote(bool isAuthenticated, bool isPositive) {
    if (!isAuthenticated) {
      _showLoginScreen(context);
    } else {
      Provider.of<Deals>(context, listen: false)
          .voteForDeal(widget.deal.id, isPositive);
    }
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
