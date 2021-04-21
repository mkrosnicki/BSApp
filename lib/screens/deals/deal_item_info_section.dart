import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/rate_bar.dart';
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
    super.initState();
    initializeDateFormatting();
    _dateFormat = new DateFormat.yMMMMd('pl');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) => Container(
        height: 130,
        child: Padding(
          padding:
              EdgeInsets.only(left: 14.0, right: 10.0, top: 5.0, bottom: 5.0),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            arguments: widget.deal),
                        child: Flex(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 8,
                              child: Text(
                                widget.deal.title,
                                style: TextStyle(
                                  fontSize: 13,
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
                                        ? Icon(CupertinoIcons.heart_fill,
                                            size: 20)
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
                            color: Colors.blue.shade500,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${widget.deal.regularPrice} zł',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                // width: double.infinity,
                child: Row(
                  // direction: Axis.horizontal,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column(
                    //   children: [
                    //     Text(
                    //       'Internet',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.black54,
                    //       ),
                    //     ),
                    //     Text(
                    //       'Internet',
                    //       style: TextStyle(
                    //         fontSize: 12,
                    //         color: Colors.black54,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    _buildStatisticTile('Lokalizacja', 'Intetnet', false, true),
                    _buildStatisticTile('Dodana', '${_dateFormat.format(widget.deal.addedAt)}', false, true),
                    // Text(
                    //   '${_dateFormat.format(widget.deal.addedAt)}',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Consumer<Deals>(
                      builder: (context, dealsData, child) => Expanded(
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              children: [
                                RateBar(
                                  dealsData
                                          .findById(widget.deal.id)
                                          .numberOfPositiveVotes +
                                      15,
                                  dealsData
                                          .findById(widget.deal.id)
                                          .numberOfNegativeVotes +
                                      10,
                                  Provider.of<Deals>(context)
                                      .wasVotedPositivelyBy(
                                          widget.deal.id, authData.userId),
                                  Provider.of<Deals>(context)
                                      .wasVotedNegativelyBy(
                                          widget.deal.id, authData.userId),
                                  () => _vote(authData.isAuthenticated, true),
                                  () => _vote(authData.isAuthenticated, false),
                                ),
                              ],
                            ),
                            Text(
                              'ZOBACZ',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _vote(bool isAuthenticated, bool isPositive) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      Provider.of<Deals>(context, listen: false)
          .voteForDeal(widget.deal.id, isPositive);
    }
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

  static const statNameStyle = TextStyle(fontSize: 11, color: Colors.grey);
  static const activeMenuItemStyle =
  TextStyle(fontSize: 11, color: Colors.black);

  _buildStatisticTile(String title, String text, bool borderLeft, bool borderRight) {
    return Container(
      // width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(right: 8.0),
      margin: const EdgeInsets.only(right: 8.0),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 0.5,
        children: [
          Text(
            title,
            style: statNameStyle,
          ),
          Text(
            text,
            style: activeMenuItemStyle,
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
            left: borderLeft ? BorderSide(
                color: MyColorsProvider.GREY_BORDER_COLOR, width: 1) : BorderSide(style: BorderStyle.none),
            right: borderRight ? BorderSide(
                color: MyColorsProvider.GREY_BORDER_COLOR, width: 1) : BorderSide(style: BorderStyle.none)
        ),
      ),
    );
  }

}
