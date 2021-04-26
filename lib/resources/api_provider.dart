import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String _baseUrl = "https://api.chucknorris.io/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw HttpException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url) async {
    return null;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw HttpException(response.body.toString());
      case 401:

      case 403:
        throw HttpException(response.body.toString());
      case 500:

      default:
        throw HttpException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}