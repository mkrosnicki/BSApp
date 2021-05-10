import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/searches/observed_search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservedSearchesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<Searches>(context, listen: false).fetchObservedSearches(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            return Consumer<Searches>(builder: (context, searchesData, child) {
              return Consumer<CurrentUser>(
                  builder: (context, currentUser, child) {
                final List<SearchModel> observedDeals = searchesData
                    .savedSearches
                    .where((element) => currentUser.observesSearch(element))
                    .toList();
                return observedDeals.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          final SearchModel search = observedDeals[index];
                          return ObservedSearchItem(search);
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
          'Nie obserwujesz żadnych wyszukiwań',
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
