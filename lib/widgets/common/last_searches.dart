import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/services/last_searches_util_service.dart';
import 'package:BSApp/widgets/common/no_old_searches_info.dart';
import 'package:BSApp/widgets/common/server_error_splash.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'last_search_item.dart';
import 'loading_indicator.dart';

class LastSearches extends StatefulWidget {
  @override
  _LastSearchesState createState() => _LastSearchesState();
}

class _LastSearchesState extends State<LastSearches> {
  List<FilterSettings> _cachedFilterSettings = [];

  Future<void> _initCookies() async {
    _cachedFilterSettings =
        await LastSearchesUtilService.getCachedFilterSettings();
    final logger = Logger();
    logger.i(_cachedFilterSettings);
  }

  @override
  Widget build(BuildContext context) {
    _initCookies(); // todo remove?
    return FutureBuilder(
      future: _initCookies(), // todo keep??
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: ServerErrorSplash(),
            );
          } else {
            if (_cachedFilterSettings.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Ostatnie wyszukiwania',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    );
                  } else {
                    return LastSearchItem(_cachedFilterSettings[index - 1],
                        () => _removeFilterSettingsAt(index - 1));
                  }
                },
                itemCount: _cachedFilterSettings.length + 1,
              );
            } else {
              return Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
                alignment: Alignment.topCenter,
                child: NoOldSearchesInfo(),
              );
            }
          }
        }
      },
    );
  }

  void _removeFilterSettingsAt(int index) {
    setState(() {
      LastSearchesUtilService.removeFilterSettingsAt(index);
    });
  }
}
