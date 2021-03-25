import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/authentication/login_registration_screen.dart';
import 'package:BSApp/widgets/common/my_border_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealDetailsActions extends StatelessWidget {
  final DealModel deal;

  // todo pass only deal id?
  DealDetailsActions(this.deal);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Divider(),
          Consumer<Deals>(
              builder: (context, dealsData, child) => Consumer<Auth>(
              builder: (context, authData, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButtonWithPaddings(
                    label: 'Nieprzydatna',
                    iconData: CupertinoIcons.hand_thumbsdown_fill,
                    function: () =>
                        _vote(context, authData.isAuthenticated, false),
                    trailing: '${dealsData.findById(deal.id).numberOfNegativeVotes}',
                    color: Colors.red,
                    isActive: Provider.of<Deals>(context)
                        .wasVotedNegativelyBy(deal.id, authData.userId),
                  ),
                  _buildButtonWithPaddings(
                    label: 'Przydatna',
                    iconData: CupertinoIcons.hand_thumbsup_fill,
                    function: () =>
                        _vote(context, authData.isAuthenticated, true),
                    trailing: '${dealsData.findById(deal.id).numberOfPositiveVotes}',
                    color: Colors.green,
                    isActive: Provider.of<Deals>(context)
                        .wasVotedPositivelyBy(deal.id, authData.userId),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  _buildButtonWithPaddings(
      {String label,
      IconData iconData,
      Function function,
      String trailing,
      Color color,
      bool isActive = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
        child: MyBorderIconButton(
            label: label,
            iconData: iconData,
            function: function,
            trailing: trailing,
            color: color,
            isActive: isActive),
      ),
    );
  }

  _vote(BuildContext context, bool isAuthenticated, bool isPositive) {
    if (!isAuthenticated) {
      _showLoginScreen(context);
    } else {
      Provider.of<Deals>(context, listen: false)
          .voteForDeal(deal.id, isPositive);
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
