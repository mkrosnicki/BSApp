import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/screens/deals/deal_search_result_screen.dart';
import 'package:BSApp/screens/deals/filter_selection_screen.dart';
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
    return AppBar(
      titleSpacing: 8,
      brightness: Brightness.light,
      backwardsCompatibility: false,
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
      title: _searchField(context),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        StreamBuilder<bool>(
          stream: _showLastSearchesStream,
          builder: (context, AsyncSnapshot<bool> showSearchPanelSnapshot) {
            final bool searchPanelVisible =
                showSearchPanelSnapshot.hasData && showSearchPanelSnapshot.data;
            return searchPanelVisible
                ? _hideLastSearchesPanelButton()
                : _openFiltersButton(context);
          },
        )
      ],
    );
  }

  Widget _openFiltersButton(BuildContext context) {
    return InkWell(
      onTap: () => _showFilterSelectionDialog(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
        child: Icon(
          CupertinoIcons.slider_horizontal_3,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _hideLastSearchesPanelButton() {
    return GestureDetector(
      onTap: () => _showLastSearchesPanel(false),
      child: const TextButton(
        child: Text(
          'Anuluj',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            letterSpacing: 0.3,
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

  void _navigateToResultsScreen(BuildContext context, String phrase) {
    Navigator.of(context).pushNamed(DealSearchResultScreen.routeName,
        arguments: FilterSettings.phrase(phrase));
    _showLastSearchesPanel(false);
  }

  Future _showFilterSelectionDialog(BuildContext context) async {
    final newFilterSettings =
        await Navigator.of(context).push(MaterialPageRoute<FilterSettings>(
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

  Future<void> _showLastSearchesPanel(bool isShowSearch) async {
    if (!isShowSearch) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
    showLastSearchesSubject.add(isShowSearch);
  }
}
