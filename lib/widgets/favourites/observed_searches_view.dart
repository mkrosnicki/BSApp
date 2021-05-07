import 'package:BSApp/providers/auth.dart';
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
    return Consumer<Auth>(
      builder: (context, auth, child) {
        if (auth.isAuthenticated) {
          return FutureBuilder(
            future: Provider.of<Searches>(context, listen: false)
                .fetchSavedSearches(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: LoadingIndicator());
              } else {
                if (snapshot.error != null) {
                  return const ServerErrorSplash();
                } else {
                  return Consumer<Searches>(
                    builder: (context, searchesData, child) {
                      return searchesData.savedSearches.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, index) =>
                                  ObservedSearchItem(
                                      searchesData.savedSearches[index]),
                              itemCount: searchesData.savedSearches.length,
                            )
                          : _buildNoObservedSearchesSplashView();
                    },
                  );
                }
              }
            },
          );
        } else {
          return _buildNoObservedSearchesSplashView();
        }
      },
    );
  }

  Widget _buildNoObservedSearchesSplashView() {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Nie obserwujesz \nżadnych wyszukiwań',
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
