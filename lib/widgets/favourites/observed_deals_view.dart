import 'package:BSApp/providers/auth.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservedDealsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (context, auth, child) {
        if (auth.isAuthenticated) {
          return FutureBuilder(
            future:
            Provider.of<CurrentUser>(context, listen: false)
                .fetchObservedDeals(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicator());
              } else {
                if (snapshot.error != null) {
                  return const Center(
                    child: ServerErrorSplash(),
                  );
                } else {
                  return Consumer<CurrentUser>(
                    builder: (context, currentUserData, child) {
                      return currentUserData.observedDeals.isNotEmpty
                          ? ListView.builder(
                        itemBuilder: (context, index) =>
                            Column(
                              children: [
                                DealItem(currentUserData.observedDeals[index]),
                                DealItem(currentUserData.observedDeals[index]),
                                DealItem(currentUserData.observedDeals[index]),
                              ],
                            ),
                        itemCount: currentUserData.observedDeals.length,
                      )
                          : _buildNoObservedDealsSplashView();
                    },
                  );
                }
              }
            },
          );
        } else {
          return _buildNoObservedDealsSplashView();
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