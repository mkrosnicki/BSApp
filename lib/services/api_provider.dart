import 'dart:convert';
import 'dart:io';

import 'package:BSApp/models/custom_exception.dart';
import 'package:BSApp/models/illegal_request_exception.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiProvider {
  String token;

  ApiProvider({this.token});
  final logger = Logger();

  final _ProtocolType _protocolType = _ProtocolType.HTTP;
  // final String _domain = "YOUR_LOCAL_IP:PORT";
  final String _domain = "192.168.1.128:8080";


  Future<dynamic> get(String endpoint, {String token, Map<String, dynamic> requestParams}) async {
    return _sendRequest(_RequestType.GET, endpoint, token: token, requestParams: requestParams);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {String token}) async {
    return _sendRequest(_RequestType.POST, endpoint, body: body, token: token);
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> body,
      {String token}) async {
    return _sendRequest(_RequestType.PATCH, endpoint, body: body, token: token);
  }

  Future<dynamic> delete(String endpoint, {String token}) async {
    return _sendRequest(_RequestType.DELETE, endpoint, token: token);
  }

  Future<dynamic> _sendRequest(_RequestType requestType, String endpoint, {Map<String, dynamic> body, String token, Map<String, dynamic> requestParams}) async {
    var responseJson;
    try {
      final Map<String, String> headers = {};
      if (token != null) {
        headers.putIfAbsent("Authorization", () => 'Bearer $token');
      }
      if (requestType == _RequestType.POST || requestType == _RequestType.PATCH) {
        headers.putIfAbsent('Content-Type', () => 'application/json;charset=UTF-8');
      }
      final uri = _buildUri(endpoint, requestParams);
      logger.i(uri);
      var response;
      switch (requestType) {
        case _RequestType.DELETE:
          response = await http.delete(uri, headers: headers);
          break;
        case _RequestType.POST:
          response = await http.post(
            uri,
            body: json.encode(body),
            headers: headers,
          );
          break;
        case _RequestType.PATCH:
          response = await http.patch(
            uri,
            body: json.encode(body),
            headers: headers,
          );
          break;
        case _RequestType.GET:
          response = await http.get(uri, headers: headers);
          break;
        default:
          throw IllegalRequestException(
              'Request $requestType is not supported!');
      }
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Uri _buildUri(String endpoint, Map<String, dynamic> requestParams) {
    return _protocolType == _ProtocolType.HTTP ? Uri.http(domain, endpoint, requestParams) : Uri.https(domain, endpoint, requestParams);
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        String decodedBody = utf8.decode(response.bodyBytes);
        var responseJson = decodedBody.isNotEmpty
            ? json.decode(decodedBody)
            : null;
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

enum _RequestType { GET, POST, PATCH, DELETE }
enum _ProtocolType { HTTP, HTTPS }
