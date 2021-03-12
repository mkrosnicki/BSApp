import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deal_search_result_screen.dart';
import 'package:BSApp/screens/filter_selection_screen.dart';
import 'package:BSApp/widgets/deal_item.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Expanded(
            child: TextField(
              onTap: () => _showSearchPanel(true),
              onSubmitted: (searchText) {
                Navigator.of(context).pushNamed(DealSearchResultScreen.routeName);
              },
              controller: _searchTextController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.grey,
              autofocus: false,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixIconConstraints: BoxConstraints.loose(
                    Size.square(30),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    gapPadding: 5,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    gapPadding: 5,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  hintText: 'Czego szukasz?',
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white),
            ),
          ),
          if (_isSearchPanelVisible)
            GestureDetector(
              onTap: () => _showSearchPanel(false),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Anuluj',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
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
    print(_isSearchPanelVisible);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: _createSearchBox(),
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

  Future _openFiltersScreen(BuildContext context) async {
    var returnedValue =
        await Navigator.of(context).push(new MaterialPageRoute<String>(
            builder: (BuildContext context) {
              return FilterSelectionScreen();
            },
            fullscreenDialog: true));
    _searchTextController.text = returnedValue;
    print(returnedValue);
  }
}
