import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/widgets/bars/app_bar_search_input.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/cupertino.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          titleSpacing: 8,
          title: _createSearchBox(),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
              child: Container(
                color: MyColorsProvider.GREY_BORDER_COLOR,
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(4.0)),
          actions: [
            if (!_isSearchPanelVisible) InkWell(
              onTap: () => _showFilterSelectionDialog(context),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                child: Icon(CupertinoIcons.slider_horizontal_3, color: Colors.black87,),
              ),
            ),
            if (_isSearchPanelVisible)
              GestureDetector(
                onTap: () => _showSearchPanel(false),
                child: TextButton(
                  child: Text(
                    'Anuluj',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              )
          ],
        ),
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

  Future _showFilterSelectionDialog(BuildContext context) async {
    var newFilterSettings =
    await Navigator.of(context).push(new MaterialPageRoute<FilterSettings>(
        builder: (BuildContext context) {
          return FilterSelectionScreen();
        },
        settings: RouteSettings(arguments: FilterSettings()),
        fullscreenDialog: true));
    if (newFilterSettings != null) {
      Navigator.of(context).pushNamed(DealSearchResultScreen.routeName,
          arguments: newFilterSettings);
    }
  }

}
