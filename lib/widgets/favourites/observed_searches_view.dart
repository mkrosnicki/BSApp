import 'package:BSApp/models/search_model.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/providers/searches.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/login_to_continue_splash.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:BSApp/widgets/searches/observed_search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObservedSearchesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        if (currentUser.isAuthenticated) {
          return FutureBuilder(
            future: Provider.of<Searches>(context, listen: false).fetchObservedSearches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicator());
              } else {
                if (snapshot.error != null) {
                  return const Center(
                    child: ServerErrorSplash(),
                  );
                } else {
                  return Consumer<Searches>(
                    builder: (context, searchesData, child) {
                      final List<SearchModel> observedSearches =
                          searchesData.searches.where((element) => currentUser.observesSearch(element)).toList();
                      return observedSearches.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                final SearchModel search = observedSearches[index];
                                return ObservedSearchItem(search);
                              },
                              itemCount: observedSearches.length,
                            )
                          : _buildNoObservedDealsSplashView();
                    },
                  );
                }
              }
            },
          );
        } else {
          return const LoginToContinueSplash('Zaloguj się, aby zobaczyć\n zapisane wyszukiwania');
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
          style: TextStyle(fontSize: 18, height: 1.5, fontWeight: FontWeight.w600, color: MyColorsProvider.LIGHT_GRAY),
        ),
      ),
    );
  }
}
