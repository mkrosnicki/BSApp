import 'package:BSApp/providers/deals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsScreen extends StatelessWidget {

  static const routeName = 'deal-details';

  @override
  Widget build(BuildContext context) {
    final dealId = ModalRoute.of(context).settings.arguments as String;
    final deal = Provider.of<Deals>(context, listen: false).findById(dealId);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network('https://dadi-shop.pl/img/sklep-z-w%C3%B3zkami-dla-dzieci-g%C5%82%C4%99bokie-spacerowe-dadi-shop-logo-1526467719.jpg'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  vertical: 5.0, horizontal: 8.0),
              child: Container(
                color: Color.fromRGBO(249, 250, 251, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        child: Icon(Icons.favorite_border, size: 16,),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 8.0),
                        child: Icon(Icons.mark_chat_unread_outlined, size: 16,),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(deal.dealType.toString()),
                  Text(deal.category),
                  Text(deal.regularPrice.toString()),
                  Row(children: [
                    Text('${deal.currentPrice.toString()} zł'),
                    Padding(padding: EdgeInsets.all(4.0),
                        child: Text('•')),
                    Text(deal.discountString),
                  ],),
                  Text(deal.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
