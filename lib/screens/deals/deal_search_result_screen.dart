import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/providers/deals.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
import 'package:BSApp/widgets/bars/app_bar_search_input.dart';
import 'package:BSApp/widgets/bars/my_navigation_bar.dart';
import 'package:BSApp/widgets/deals/deal_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/category_selection_screen.dart';

class DealSearchResultScreen extends StatelessWidget {
  static const routeName = '/deal-search';

  _openCategorySelector(BuildContext context) async {
    var returnedValue = await Navigator.of(context)
        .pushNamed(CategorySelectionScreen.routeName);
  }

  final _searchTextController = TextEditingController();

  _createSearchBox(BuildContext context) {
    _searchTextController.text =
        ModalRoute.of(context).settings.arguments as String;
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      // color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_back),
            ),
          ),
          AppBarSearchInput(
            onTapInputFunction: () {},
            onSubmitInputFunction: (_) {},
            searchInputController: _searchTextController,
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 8,
          title: _createSearchBox(context),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () => _openCategorySelector(context),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 14,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Filtry',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Znalezione okazje',
                    style: TextStyle(fontSize: 18),
                  ),
                  InkWell(
                    onTap: () => _showFilterSelectionDialog(context),
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.filter_list),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
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
                    return Flexible(
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
            ),
          ],
        ),
        bottomNavigationBar: MyNavigationBar(0));
  }

  Future _showFilterSelectionDialog(BuildContext context) async {
    var returnedValue = await Navigator.of(context).push(new MaterialPageRoute<FilterSettings>(
        builder: (BuildContext context) {
          return FilterSelectionScreen();
        },
        fullscreenDialog: true));
    Provider.of<Deals>(context).fetchDeals(requestParams: returnedValue.toParamsMap());
  }

}
