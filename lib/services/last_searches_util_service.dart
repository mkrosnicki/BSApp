
import 'package:BSApp/models/filter_settings.dart';

import 'cookies_util_service.dart';

class LastSearchesUtilService {
  static const FILTER_SETTINGS_COOKIE = 'filterSettings';

  static Future<List<FilterSettings>> getCachedFilterSettings() async {
    List<Map<String, dynamic>> cookieValues;
    await CookiesUtilService.getCookieList(FILTER_SETTINGS_COOKIE)
        .then((value) => cookieValues = value);
    return cookieValues.map((e) => FilterSettings.fromJson(e)).toList();
  }

  static Future<void> removeFilterSettingsAt(int index) {
    List<FilterSettings> cachedFilterSettings;
    getCachedFilterSettings()
        .then((value) => cachedFilterSettings = value)
        .then((_) {
      cachedFilterSettings.removeAt(index);
      CookiesUtilService.setCookieListValue(FILTER_SETTINGS_COOKIE,
          cachedFilterSettings.map((e) => e.toJson()).toList());
    });
  }

  static Future<void> saveFilterSettings(FilterSettings filterSettings) {
    if (filterSettings != null) {
      List<FilterSettings> cachedFilterSettings;
      getCachedFilterSettings()
          .then((value) => cachedFilterSettings = value)
          .then((_) {
        if (!cachedFilterSettings.contains(filterSettings)) {
          cachedFilterSettings.insert(0, filterSettings);
          CookiesUtilService.setCookieListValue(FILTER_SETTINGS_COOKIE,
              cachedFilterSettings.map((e) => e.toJson()).toList());
        }
      });
    }
  }
}
