import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deal_reply_state.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/widgets/deals/deal_details_actions.dart';
import 'package:BSApp/widgets/deals/deal_details_comments.dart';
import 'package:BSApp/widgets/deals/deal_details_description.dart';
import 'package:BSApp/widgets/deals/detal_details_new_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsScreen extends StatefulWidget {
  static const routeName = '/deal-details';

  @override
  _DealDetailsScreenState createState() => _DealDetailsScreenState();
}

class _DealDetailsScreenState extends State<DealDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    final dealId = ModalRoute.of(context).settings.arguments as String;
    final deal = Provider.of<Deals>(context, listen: false).findById(dealId);
    Provider.of<DealReplyState>(context, listen: false).resetLazy();
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
                    DealDetailsActions(),
                    DealDetailsComments(deal),
                    // _buildCommentsSection(deal)
                  ],
                ),
              ),
            ),
            Consumer<DealReplyState>(
              builder: (context, replyState, child) {
                ReplyState currentReplyState = replyState.replyState;
                String commentId = replyState.commentId;
                return currentReplyState != ReplyState.NONE ? DealDetailsNewComment(
                    dealId, currentReplyState, commentId) : Container();
              },
            ),
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
                onTap: () => _toggleFavourites(deal, isFavourite, isUserLoggedIn),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 8.0),
                  child: isFavourite
                      ? Icon(
                    Icons.favorite,
                    size: 24,
                  )
                      : Icon(
                    Icons.favorite_border,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _toggleFavourites(DealModel deal, bool isFavourite, bool isUserLoggedIn) {
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
