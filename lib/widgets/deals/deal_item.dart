import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/screens/deals/deal_details_screen.dart';
import 'package:flutter/material.dart';

class DealItem extends StatelessWidget {
  final DealModel deal;

  DealItem(this.deal);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              deal.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
                      Navigator.of(context).pushNamed(DealDetailsScreen.routeName, arguments: deal.id);
                    },
                    child: Image.network(
                        'https://dadi-shop.pl/img/sklep-z-w%C3%B3zkami-dla-dzieci-g%C5%82%C4%99bokie-spacerowe-dadi-shop-logo-1526467719.jpg'),
                  ),
                ),
              ),
              Flexible(
                flex: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(deal.dealType.toString()),
                      Text(deal.category),
                      Text(deal.regularPrice.toString()),
                      Row(children: [
                        Text('${deal.currentPrice.toString()} zł'),
                        Padding(padding: EdgeInsets.all(4.0), child: Text('•')),
                        Text(deal.discountString),
                      ],),
                      Text(deal.description),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            child: Container(
              color: Color.fromRGBO(249, 250, 251, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                      child: Icon(Icons.favorite_border, size: 16,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                      child: Icon(Icons.mark_chat_unread_outlined, size: 16,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
