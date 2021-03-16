import 'package:BSApp/models/comment-mode.dart';
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/deals/deal_details_description.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/deals/deal_details_actions.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/deals/deal_details_comments.dart';
import 'file:///D:/Projects/Flutter/BSApp/lib/widgets/deals/detal_details_new_comment.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = '/deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {
  CommentMode _commentMode = CommentMode.NONE;
  String _commentToReplyId;

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
                    DealDetailsDescription(deal),
                    DealDetailsActions(_setCommentMode),
                    DealDetailsComments(deal, _setCommentMode),
                    // _buildCommentsSection(deal)
                  ],
                ),
              ),
            ),
            if (_commentMode != CommentMode.NONE)
              DealDetailsNewComment(dealId, _commentMode, _commentToReplyId),
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

  _setCommentMode(CommentMode commentMode, {String commentToReplyId}) {
    setState(() {
      _commentMode = commentMode;
      _commentToReplyId = commentToReplyId;
      print(_commentToReplyId);
      print(_commentMode);
    });
  }
}
