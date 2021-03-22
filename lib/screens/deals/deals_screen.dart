import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/widgets/bars/app_bar_search_input.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deal_search_result_screen.dart';

class DealsScreen extends StatefulWidget {
  static const routeName = '/deals';

  @override
  _DealsScreenState createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  final _searchTextController = TextEditingController();

  bool _isSearchPanelVisible = false;

  _createSearchBox() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      // color: Colors.white,
      child: Row(
        children: [
          AppBarSearchInput(
            onTapInputFunction: () => _showSearchPanel(true),
            onSubmitInputFunction: (searchText) {
              Navigator.of(context).pushNamed(DealSearchResultScreen.routeName,
                  arguments: FilterSettings.phrase(searchText));
              _showSearchPanel(false);
            },
            searchInputController: _searchTextController,
          ),
          // if (_isSearchPanelVisible)
          //   GestureDetector(
          //     onTap: () => _showSearchPanel(false),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 8.0),
          //       child: Text(
          //         'Anuluj',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 12,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  _showSearchPanel(bool isShowSearch) {
    if (_isSearchPanelVisible != isShowSearch) {
      setState(() {
        _isSearchPanelVisible = isShowSearch;
        if (!_isSearchPanelVisible) {
          FocusScope.of(context).requestFocus(new FocusNode());
          _searchTextController.text = "";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: _createSearchBox(),
        actions: [
          if (!_isSearchPanelVisible) InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
              child: Icon(Icons.filter_list),
            ),
          ),
          if (_isSearchPanelVisible)
            GestureDetector(
              onTap: () => _showSearchPanel(false),
              child: TextButton(
                child: Text(
                  'Anuluj',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            )
        ],
      ),
      body: !_isSearchPanelVisible
          ? FutureBuilder(
              future: Provider.of<Deals>(context, listen: false).fetchDeals(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.error != null) {
                    return Center(
                      child: Text('An error occurred!'),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () => _refreshDeals(context),
                      child: Consumer<Deals>(
                        builder: (context, dealsData, child) =>
                            ListView.builder(
                          itemBuilder: (context, index) =>
                              DealItem(dealsData.deals[index]),
                          itemCount: dealsData.deals.length,
                        ),
                      ),
                    );
                  }
                }
              },
            )
          : Center(
              child: Text('Brak ostatnich wyszukiwań'),
            ),
      bottomNavigationBar: MyNavigationBar(0),
    );
  }

  Future<void> _refreshDeals(BuildContext context) async {
    await Provider.of<Deals>(context, listen: false).fetchDeals();
  }
}
