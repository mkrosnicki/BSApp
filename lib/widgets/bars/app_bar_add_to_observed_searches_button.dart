import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/current_user.dart';
import 'package:BSApp/screens/authentication/auth_screen_provider.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarAddToObservedSearchesButton extends StatelessWidget {
  final FilterSettings filterSettings;

  const AppBarAddToObservedSearchesButton(this.filterSettings);

  @override
  Widget build(BuildContext context) {
    print('rebuildrebuildrebuildrebuildrebuild');
    return Consumer<CurrentUser>(
      builder: (context, currentUser, child) {
        final bool isObservedSearch = currentUser.observesFilterSettings(filterSettings);
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _saveSearch(context, filterSettings, currentUser.isAuthenticated, isObservedSearch),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Icon(CupertinoIcons.heart_fill,
                size: 20, color: isObservedSearch ? MyColorsProvider.RED_SHADY : MyColorsProvider.LIGHT_GRAY),
          ),
        );
      },
    );
  }

  void _saveSearch(BuildContext context, FilterSettings filterSettings, bool isAuthenticated, bool isObservedSearch) {
    if (isAuthenticated) {
      if (isObservedSearch) {
        Provider.of<CurrentUser>(context, listen: false).removeFromObserved(filterSettings);
      } else {
        Provider.of<CurrentUser>(context, listen: false).addToObservedSearches(filterSettings.toSaveSearchDto());
      }
    } else {
      AuthScreenProvider.showLoginScreen(context);
    }
  }
}
