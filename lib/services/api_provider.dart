import 'dart:convert';
import 'dart:io';
import 'package:BSApp/models/custom-exception.dart';
import 'package:http/http.dart' as http;

class ApiProvider {

  String token;

  ApiProvider({this.token});

  final String _baseUrl = "http://YOUR_LOCAL_IP:8080";


  Future<dynamic> get(String url, {String token}) async {
    var responseJson;
    try {
      Map<String, String> headers = {};
      if (token != null) {
        headers.putIfAbsent("Authorization", () => 'Bearer $token');
      }
      final response = await http.get(_baseUrl + url, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body, {String token}) async {
    var responseJson;
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};
      if (token != null) {
        headers.putIfAbsent("Authorization", () => 'Bearer $token');
      }
      final response = await http.post(
        _baseUrl + url,
        body: json.encode(body),
        headers: headers,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {String token}) async {
    var responseJson;
    try {
      Map<String, String> headers = {};
      if (token != null) {
        headers.putIfAbsent("Authorization", () => 'Bearer $token');
      }
      final response = await http.delete(_baseUrl + url, headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        String decodedBody = utf8.decode(response.bodyBytes);
        var responseJson = decodedBody.isNotEmpty ? json.decode(decodedBody) : null;
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.body}');
    }
  }
}
