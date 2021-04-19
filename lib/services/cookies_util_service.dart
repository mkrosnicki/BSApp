import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CookiesUtilService {

  static Future<void> clear(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cookie);
  }

  static Future<Object> getCookie(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedCookie = json.decode(prefs.getString(cookie)) as Map<String, Object>;
    return extractedCookie;
  }

  static Future<List<Map<String, dynamic>>> getCookieList(String cookie) async {
    final prefs = await SharedPreferences.getInstance();
    final extractedCookie = json.decode(prefs.getString(cookie)) as List<dynamic>;
    print('extr');
    print(extractedCookie);
    List<Map<String, dynamic>> extractedCookieList = extractedCookie.map((e) => e as Map<String, dynamic>).toList();
    print(extractedCookieList);
    return extractedCookieList;
  }

  static Future<void> setCookieListValue(String cookie, List<dynamic> listValue) async {
    final String cookieData = json.encode(listValue);
    setCookieStringValue(cookie, cookieData);
  }

  static Future<void> setCookieMapValue(String cookie, Map<String, dynamic> mapValue) async {
    final String cookieData = json.encode(mapValue);
    setCookieStringValue(cookie, cookieData);
  }

  static Future<void> setCookieStringValue(String cookie, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(cookie, value);
  }

}