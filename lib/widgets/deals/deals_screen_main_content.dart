import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/models/sorting_type.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/%20categories/categories_scrollable.dart';
import 'package:BSApp/widgets/common/deals_not_found.dart';
import 'package:BSApp/widgets/common/loading_indicator.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deal_item.dart';

class DealsScreenMainContent extends StatefulWidget {
  @override
  _DealsScreenMainContentState createState() => _DealsScreenMainContentState();
}

class _DealsScreenMainContentState extends State<DealsScreenMainContent> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  final FilterSettings filterSettings = FilterSettings.sort(SortingType.NEWEST);

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        final dealsProvider = Provider.of<Deals>(context, listen: false);
        if (dealsProvider.canLoadPage(_currentPage + 1)) {
          dealsProvider.fetchDealsPaged(requestParams: filterSettings.toParamsMap(), pageNo: ++_currentPage);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Deals>(context, listen: false).fetchDealsPaged(requestParams: filterSettings.toParamsMap()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return const Expanded(
              child: Center(
                child: ServerErrorSplash(),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshDeals(context),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    CategoriesScrollable(_refreshDeals),
                    Consumer<Deals>(
                      builder: (context, dealsData, child) {
                        if (dealsData.deals.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DealItem(dealsData.deals[index]);
                            },
                            itemCount: dealsData.deals.length,
                          );
                        } else {
                          return const DealsNotFound();
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _refreshDeals(BuildContext context) async {
    _currentPage = 0;
    await Provider.of<Deals>(context, listen: false).fetchDealsPaged(requestParams: filterSettings.toParamsMap(), pageNo: _currentPage);
  }
}
