import 'dart:convert';
import 'dart:io';
import 'package:BSApp/models/CustomException.dart';
import 'package:http/http.dart' as http;

class ApiProvider {


  final String _baseUrl = "http://YOUR_LOCAL_IP:8080";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await http.post(
        _baseUrl + url,
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
