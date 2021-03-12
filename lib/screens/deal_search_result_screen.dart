import 'package:BSApp/widgets/app_bar_search_input.dart';
import 'package:BSApp/widgets/my_navigation_bar.dart';
import 'package:flutter/material.dart';

class DealSearchResultScreen extends StatelessWidget {
  static const routeName = '/deal-search';

  final _searchTextController = TextEditingController();

  _createSearchBox(BuildContext context) {
    _searchTextController.text = ModalRoute.of(context).settings.arguments as String;
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
        body: Center(
          child: Text('center'),
        ),
        bottomNavigationBar: MyNavigationBar(0));
  }
}
