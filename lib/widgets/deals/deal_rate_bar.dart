
import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/widgets/common/rate_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealRateBar extends StatelessWidget {
  final String dealId;

  const DealRateBar(this.dealId);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, authData, child) {
        return Consumer<Deals>(
          builder: (context, dealsData, child) {
            final DealModel deal = dealsData.findById(dealId);
            final int positiveVotes = deal.positiveVoters.length;
            final int negativeVotes = deal.negativeVoters.length;
            final bool hasPositiveVote = deal.hasPositiveVoteFrom(authData.userId);
            final bool hasNegativeVote = deal.hasNegativeVoteFrom(authData.userId);
            return RateBar(
              positiveVotes,
              negativeVotes,
              hasPositiveVote,
              hasNegativeVote,
              hasPositiveVote ? () {} : () => _vote(context, authData.isAuthenticated, true),
              hasNegativeVote ? () {} : () => _vote(context, authData.isAuthenticated, false),
            );
          },
        );
      },
    );
  }

  void _vote(BuildContext context, bool isAuthenticated, bool isPositive) {
    if (!isAuthenticated) {
      AuthScreenProvider.showLoginScreen(context);
    } else {
      Provider.of<Deals>(context, listen: false).voteForDeal(dealId, isPositive);
    }
  }
}
