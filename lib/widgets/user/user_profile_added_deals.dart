import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileAddedDeals extends StatelessWidget {
  final String userId;

  const UserProfileAddedDeals(this.userId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Deals>(context, listen: false).fetchDealsAddedBy(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            return Consumer<Deals>(
              builder: (context, dealsData, child) {
                return dealsData.deals.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => DealItem(dealsData.deals[index]),
                        itemCount: dealsData.deals.length)
                    : _buildNoAddedDealsSplashView();
              },
            );
          }
        }
      },
    );
  }

  Widget _buildNoAddedDealsSplashView() {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      height: 500,
      width: double.infinity,
      color: Colors.white,
      child: const Padding(
        padding: EdgeInsets.only(top: 120.0),
        child: Text(
          'Brak dodanych okazji',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
