import 'package:BSApp/widgets/common/last_searches.dart';
import 'package:BSApp/widgets/deals/deals_screen_app_bar.dart';
import 'package:BSApp/widgets/deals/deals_screen_main_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class DealsScreen extends StatefulWidget {
  static const routeName = '/deals';

  @override
  _DealsScreenState createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  final PublishSubject<bool> _showLastSearchesSubject =
      PublishSubject<bool>();

  Stream<bool> get _showLLastSearchesStream => _showLastSearchesSubject.stream;

  @override
  Widget build(BuildContext context) {
    _showLastSearchesSubject.add(false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: DealsScreenAppBar(_showLastSearchesSubject),
      ),
      body: StreamBuilder<bool>(
        stream: _showLLastSearchesStream,
        builder: (context, AsyncSnapshot<bool> showSearchPanelSnapshot) {
          final bool showSearches =
              showSearchPanelSnapshot.hasData && showSearchPanelSnapshot.data;
          if (!showSearches) {
            return SafeArea(
              child: DealsScreenMainContent(),
            );
          } else {
            return LastSearches();
          }
        },
      ),
    );
  }
}
