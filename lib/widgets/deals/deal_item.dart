import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:BSApp/screens/users/user_profile_screen.dart';
import 'package:flutter/material.dart';

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
                          height: 100,
                          child: Image.network(
                            'https://dadi-shop.pl/img/sklep-z-w%C3%B3zkami-dla-dzieci-g%C5%82%C4%99bokie-spacerowe-dadi-shop-logo-1526467719.jpg',
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(2.0),
                            // color: Theme.of(context).accentColor,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context).accentColor,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            DealDetailsScreen.routeName,
                            arguments: deal.id),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0.0),
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
                                child: Icon(Icons.favorite_border),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToUserProfileScreen(context),
                        child: Text(
                          deal.addedByUsername,
                          style: TextStyle(color: Colors.blue),
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
                      Text(deal.description),
                    ],
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
}
