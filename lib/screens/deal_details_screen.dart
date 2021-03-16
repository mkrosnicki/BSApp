import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/comments.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/new_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = 'deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dealId = ModalRoute.of(context).settings.arguments as String;
    final deal = Provider.of<Deals>(context, listen: false).findById(dealId);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        padding: const EdgeInsets.all(0),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        'https://dadi-shop.pl/img/sklep-z-w%C3%B3zkami-dla-dzieci-g%C5%82%C4%99bokie-spacerowe-dadi-shop-logo-1526467719.jpg'),
                    _buildDealActionsSection(deal),
                    _buildDealDescriptionSection(deal),
                    _buildCommentsSection(deal)
                  ],
                ),
              ),
            ),
            NewComment(),
          ],
        ),
      ),
    );
  }

  _buildDealActionsSection(DealModel deal) {
    final isUserLoggedIn =
        Provider.of<Auth>(context, listen: false).isAuthenticated;
    bool isFavourite = Provider.of<Deals>(context).isObservedDeal(deal);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Container(
        color: Color.fromRGBO(249, 250, 251, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => _toggleFavourites(deal, isFavourite),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 8.0),
                  child: isUserLoggedIn
                      ? isFavourite
                          ? Icon(
                              Icons.favorite,
                              size: 24,
                            )
                          : Icon(
                              Icons.favorite_border,
                              size: 24,
                            )
                      : Icon(null),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                child: Icon(
                  Icons.mark_chat_unread_outlined,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDealDescriptionSection(DealModel deal) {
    return Column(
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(deal.dealType.toString()),
              Text(deal.category),
              Text(deal.regularPrice.toString()),
              Row(
                children: [
                  Text('${deal.currentPrice.toString()} zł'),
                  Padding(padding: EdgeInsets.all(4.0), child: Text('•')),
                  Text(deal.discountString),
                ],
              ),
              Text(deal.description),
            ],
          ),
        )
      ],
    );
  }

  _buildCommentsSection(DealModel deal) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Container(
        color: Color.fromRGBO(249, 250, 251, 1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Column(
            children: [
              Text('Komentarze', style: TextStyle(fontSize: 16)),
              FutureBuilder(
                future: Provider.of<Comments>(context, listen: false)
                    .fetchCommentsForDeal(deal.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.error != null) {
                      return Center(
                        child: Text('An error occurred!'),
                      );
                    } else {
                      return Consumer<Comments>(
                        builder: (context, commentsData, child) => Column(
                          children: commentsData.dealComments
                              .map((e) => Text(e.content))
                              .toList(),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _toggleFavourites(DealModel deal, bool isFavourite) {
    if (isFavourite) {
      Provider.of<Deals>(context, listen: false)
          .deleteFromObservedDeals(deal.id);
    } else {
      Provider.of<Deals>(context, listen: false).addToObservedDeals(deal.id);
    }
  }
}
