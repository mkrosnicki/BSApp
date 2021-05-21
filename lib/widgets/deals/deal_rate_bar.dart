import 'dart:math';

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
            return RateBar(
              dealsData.findById(dealId).numberOfPositiveVotes,
              dealsData.findById(dealId).numberOfNegativeVotes,
              deal.hasPositiveVoteFrom(authData.userId),
              deal.hasNegativeVoteFrom(authData.userId),
                  () => _vote(context, authData.isAuthenticated, true),
                  () => _vote(context, authData.isAuthenticated, false),
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
