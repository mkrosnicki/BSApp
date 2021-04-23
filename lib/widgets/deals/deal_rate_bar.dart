import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/widgets/common/rate_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealRateBar extends StatelessWidget {
  final DealModel deal;

  DealRateBar(this.deal);

  @override
  Widget build(BuildContext context) {
    var dealsProvider = Provider.of<Deals>(context);
    return Consumer<Auth>(
      builder: (context, authData, child) => Consumer<Deals>(
        builder: (context, dealsData, child) => RateBar(
          dealsData.findById(deal.id).numberOfPositiveVotes + 30,
          dealsData.findById(deal.id).numberOfNegativeVotes + 7,
          dealsProvider.wasVotedPositivelyBy(deal.id, authData.userId),
          dealsProvider.wasVotedNegativelyBy(deal.id, authData.userId),
          () => _vote(context, authData.isAuthenticated, true),
          () => _vote(context, authData.isAuthenticated, false),
        ),
      ),
    );
  }

  _vote(BuildContext context, bool isAuthenticated, bool isPositive) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      Provider.of<Deals>(context, listen: false)
          .voteForDeal(deal.id, isPositive);
    }
  }
}
