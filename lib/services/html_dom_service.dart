import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class HtmlDomService {

  static Future<List<String>> getImageUrlsFrom(String url) async {
    final response = await http.get(Uri.parse(url));
    final dom.Document document = parser.parse(response.body);
    final List<dom.Element> elements = document.getElementsByTagName('img');
    List<String> list = [];
    list = elements.map((element) => element.attributes['src']).toList();
    list.removeWhere((item) => item == null);
    list.removeWhere((item) => !item.startsWith('http'));
    return Future.value(list);
  }
}