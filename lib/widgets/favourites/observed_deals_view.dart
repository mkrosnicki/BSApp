import 'package:BSApp/models/deal_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservedDealsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Deals>(context, listen: false).fetchMyObservedDeals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            return Consumer<Deals>(builder: (context, dealsData, child) {
              return Consumer<CurrentUser>(
                  builder: (context, currentUser, child) {
                final List<DealModel> observedDeals = dealsData.deals
                    .where((element) => currentUser.observesDeal(element))
                    .toList();
                return observedDeals.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          final DealModel deal = observedDeals[index];
                          return DealItem(deal);
                        },
                        itemCount: observedDeals.length,
                      )
                    : _buildNoObservedDealsSplashView();
              });
            });
          }
        }
      },
    );
  }

  Widget _buildNoObservedDealsSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nie obserwujesz żadnych okazji',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
