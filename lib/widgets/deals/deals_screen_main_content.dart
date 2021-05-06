import 'package:BSApp/models/category_model.dart';
import 'package:BSApp/providers/categories.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/%20categories/categories_scrollable.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deal_item.dart';

class DealsScreenMainContent extends StatelessWidget {
  List<CategoryModel> _allCategories;

  @override
  Widget build(BuildContext context) {
    _initCategories(context);
    return FutureBuilder(
      future: Provider.of<Deals>(context, listen: false).fetchDeals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            return Flexible(
              child: RefreshIndicator(
                onRefresh: () => _refreshDeals(context),
                child: Consumer<Deals>(
                  builder: (context, dealsData, child) => ListView.builder(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return CategoriesScrollable(_allCategories);
                      } else {
                        return DealItem(dealsData.deals[index - 1]);
                      }
                    },
                    itemCount: dealsData.deals.length + 1,
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _initCategories(BuildContext context) async {
    if (_allCategories == null) {
      await Provider.of<Categories>(context, listen: false)
          .fetchCategories()
          .then((_) {
        _allCategories =
            Provider.of<Categories>(context, listen: false).categories;
      });
    }
  }

  Future<void> _refreshDeals(BuildContext context) async {
    await Provider.of<Deals>(context, listen: false).fetchDeals();
  }
}
