import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/services/last_searches_util_service.dart';
import 'package:BSApp/widgets/common/no_old_searches_info.dart';
import 'package:flutter/material.dart';

import 'last_search_item.dart';

class LastSearches extends StatefulWidget {
  @override
  _LastSearchesState createState() => _LastSearchesState();
}

class _LastSearchesState extends State<LastSearches> {
  List<FilterSettings> _cachedFilterSettings = [];

  _initCookies() async {
    _cachedFilterSettings =
        await LastSearchesUtilService.getCachedFilterSettings();
    print(_cachedFilterSettings);
  }

  @override
  Widget build(BuildContext context) {
    _initCookies();
    return FutureBuilder(
      future: _initCookies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.error != null) {
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            if (_cachedFilterSettings.isNotEmpty) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Ostatnie wyszukiwania',
                        style: const TextStyle(
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
    // return _cachedFilterSettings.isNotEmpty
    //     ? ListView.builder(
    //         scrollDirection: Axis.vertical,
    //         shrinkWrap: true,
    //         itemBuilder: (context, index) => LastSearchItem(index),
    //         itemCount: 5,
    //       )
    //     : Center(
    //         child: Text('Brak ostatnich wyszukiwań'),
    //       );
  }

  _removeFilterSettingsAt(int index) {
    setState(() {
      LastSearchesUtilService.removeFilterSettingsAt(index);
    });
  }
}
