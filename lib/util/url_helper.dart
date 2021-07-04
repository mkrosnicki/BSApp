class UrlHelper {

  static const String HTTP_PREFIX = 'http://';
  static const String HTTPS_PREFIX = 'https://';
  // ignore: avoid_classes_with_only_static_members

  static bool isUrl(String value) {
    String urlToCheck;
    if (value.startsWith(HTTPS_PREFIX) || value.startsWith(HTTP_PREFIX)) {
      urlToCheck = value;
    } else {
      urlToCheck = getWithPrefix(value);
    }
    final RegExp urlRegex = RegExp(r'https?://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?', caseSensitive: false);
    return urlRegex.hasMatch(urlToCheck);
  }

  static String getWithPrefix(String url) {
    if (url.startsWith(HTTPS_PREFIX) || url.startsWith(HTTP_PREFIX)) {
      return url;
    }
    return HTTPS_PREFIX + url;
  }

}