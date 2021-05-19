import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/%20categories/categories_scrollable.dart';
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

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        final dealsProvider = Provider.of<Deals>(context, listen: false);
        if (dealsProvider.canLoadPage(_currentPage + 1)) {
          dealsProvider.fetchDealsPaged(pageNo: ++_currentPage);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Deals>(context, listen: false).fetchDealsPaged(),
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
            return RefreshIndicator(
              onRefresh: () => _refreshDeals(context),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    const CategoriesScrollable(),
                    Consumer<Deals>(
                      builder: (context, dealsData, child) => ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return DealItem(dealsData.deals[index]);
                        },
                        itemCount: dealsData.deals.length,
                      ),
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
    await Provider.of<Deals>(context, listen: false).fetchDealsPaged(pageNo: _currentPage);
  }
}
