import 'package:BSApp/models/filter_settings.dart';
import 'package:BSApp/services/cookies_util_service.dart';
import 'package:flutter/material.dart';

import 'last_search_item.dart';

class LastSearches extends StatelessWidget {
  List<FilterSettings> _cachedFilterSettings = [];

  _initCookies() async {
    List<Map<String, dynamic>> cookieValues;
    await CookiesUtilService.getCookieList('filterSettings')
        .then((value) => cookieValues = value);
    _cachedFilterSettings =
        cookieValues.map((e) => FilterSettings.fromJson(e)).toList();
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
            return _cachedFilterSettings.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text('Ostatnie wyszukiwania', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return LastSearchItem(_cachedFilterSettings[index]);
                        },
                        itemCount: _cachedFilterSettings.length,
                      ),
                    ],
                  )
                : Center(
                    child: Text('Brak ostatnich wyszukiwań'),
                  );
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
}
