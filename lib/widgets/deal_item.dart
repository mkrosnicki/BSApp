import 'package:BSApp/models/deal_model.dart';
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
                  child: Image.network(
                      'https://dadi-shop.pl/img/sklep-z-w%C3%B3zkami-dla-dzieci-g%C5%82%C4%99bokie-spacerowe-dadi-shop-logo-1526467719.jpg'),
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
                      Text(deal.currentPrice.toString()),
                      Text(deal.regularPrice.toString()),
                      Text(deal.discountString),
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
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                color: Color.fromRGBO(249, 250, 251, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  child: Text('ACTIONS AREA'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
