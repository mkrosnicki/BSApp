import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'deal_details_screen.dart';

class DealItemInfoSection extends StatefulWidget {
  final DealModel deal;

  DealItemInfoSection(this.deal);

  @override
  _DealItemInfoSectionState createState() => _DealItemInfoSectionState();
}

class _DealItemInfoSectionState extends State<DealItemInfoSection> {
  DateFormat _dateFormat;

  @override
  void initState() {
    initializeDateFormatting();
    _dateFormat = new DateFormat.yMMMMd('pl');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Container(
        height: 120,
        child: Padding(
          padding: EdgeInsets.only(left: 14.0, right: 10.0, top: 5.0, bottom: 0.0),
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
                        onTap: () => Navigator.of(context).pushNamed(
                            DealDetailsScreen.routeName,
                            arguments: widget.deal.id),
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                builder: (context, dealsData, child) {
                                  return GestureDetector(
                                    onTap: () => _toggleFavourites(
                                        context,
                                        widget.deal,
                                        dealsData.isObservedDeal(widget.deal),
                                        authData.isAuthenticated),
                                    child: dealsData.isObservedDeal(widget.deal)
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
                            decoration: TextDecoration.lineThrough),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Consumer<Deals>(
                          builder: (context, dealsData, child) => Flexible(
                            flex: 1,
                            child: Flex(
                              direction: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      _vote(authData.isAuthenticated, false),
                                  child: Provider.of<Deals>(context)
                                          .wasVotedNegativelyBy(
                                              widget.deal.id, authData.userId)
                                      ? Icon(
                                          CupertinoIcons.hand_thumbsdown_fill,
                                          size: 16,
                                        )
                                      : Icon(
                                          CupertinoIcons.hand_thumbsdown,
                                          size: 16,
                                        ),
                                ),
                                Text(dealsData
                                    .findById(widget.deal.id)
                                    .numberOfPoints
                                    .toString()),
                                GestureDetector(
                                  onTap: () =>
                                      _vote(authData.isAuthenticated, true),
                                  child: Provider.of<Deals>(context)
                                          .wasVotedPositivelyBy(
                                              widget.deal.id, authData.userId)
                                      ? Icon(
                                          CupertinoIcons.hand_thumbsup_fill,
                                          size: 16,
                                        )
                                      : Icon(
                                          CupertinoIcons.hand_thumbsup,
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