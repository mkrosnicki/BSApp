import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/deals/add_deal_screen.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:BSApp/util/my_colors_provider.dart';
import 'package:BSApp/util/my_styling_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class DealsScreenAppBar extends StatelessWidget {
  final _searchTextController = TextEditingController();
  final _focusNode = FocusNode();

  final PublishSubject<bool> showLastSearchesSubject;

  DealsScreenAppBar(this.showLastSearchesSubject);

  Stream<bool> get _showLastSearchesStream => showLastSearchesSubject.stream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _showLastSearchesStream,
      builder: (context, AsyncSnapshot<bool> showSearchPanelSnapshot) {
        final bool isSearchMode = showSearchPanelSnapshot.hasData && showSearchPanelSnapshot.data;
        return isSearchMode ? _searchAppBar(context) : _mainAppBar(context);
      },
    );
  }

  Widget _searchAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 4,
      leadingWidth: 0,
      centerTitle: true,
      title: _searchField(context),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [_stopSearchModeButton()],
    );
  }

  Widget _mainAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 100.0,
      centerTitle: true,
      leading: _addNewDealButton(context),
      title: const Text(
        'Okazje',
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      backgroundColor: MyColorsProvider.BLUE,
      elevation: 0,
      actions: [
        _startSearchModeButton(context),
      ],
    );
  }

  Widget _startSearchModeButton(BuildContext context) {
    return InkWell(
      onTap: () => _showLastSearchesPanel(true),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        margin: const EdgeInsets.only(right: 8.0),
        child: const Icon(
          CupertinoIcons.search,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _stopSearchModeButton() {
    return GestureDetector(
      onTap: () => _showLastSearchesPanel(false),
      child: const TextButton(
        child: Text(
          'Anuluj',
          style: TextStyle(
            color: MyColorsProvider.DEEP_BLUE,
            fontSize: 12,
            // letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _addNewDealButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6.0),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () => _navigateToAddDealScreen(context),
        child: const TextButton(
          child: Text(
            'Dodaj',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }

  Widget _searchField(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.infinity,
      child: TextField(
        onTap: () => _showLastSearchesPanel(true),
        controller: _searchTextController,
        focusNode: _focusNode,
        onSubmitted: (text) => _navigateToResultsScreen(context, text),
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 12),
        decoration: MyStylingProvider.TEXT_FIELD_DECORATION.copyWith(
          hintText: 'Czego szukasz?',
          prefixIcon: const Padding(
            padding: EdgeInsets.all(0.0),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.black54,
              size: 15,
            ),
          ),
          prefixIconConstraints: BoxConstraints.tight(
            const Size.square(30),
          ),
        ),
      ),
    );
  }

  void _navigateToResultsScreen(BuildContext context, String phrase) async {
    var result = await Navigator.of(context).pushNamed(DealSearchResultScreen.routeName, arguments: FilterSettings.phrase(phrase));
    if (result != null && result == true) {
      _showLastSearchesPanel(false);
    }
  }

  void _navigateToAddDealScreen(BuildContext context) {
    Navigator.of(context).pushNamed(AddDealScreen.routeName);
  }

  Future<void> _showLastSearchesPanel(bool isShowSearch) async {
    if (!isShowSearch) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
    showLastSearchesSubject.add(isShowSearch);
  }
}
