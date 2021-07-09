import 'dart:io';
import 'package:http/http.dart' as http;
import '../utility/constants.dart' as Constants;

import 'app_exceptions.dart';

class ApiClient {

  final  httpClient = http.Client() ;
  final String _baseUrl = Constants.BASE_URL;

  Future<dynamic> get(String url) async {
    print('Api Get, url $_baseUrl$url');

    var responseJson;
    try {
      final response = await http.get(_baseUrl + url,  headers: Constants.headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      // print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body) async {
    print('Api Post, url $_baseUrl$url');
    print('parameters:' + body.toString());

    var responseJson;
    try {
      final response = await http.post(_baseUrl + url, body: body, headers: Constants.headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      // print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }

  Future<dynamic> postForm(String url, Map body) async {
    print('Api Post, url :' + url);
    print('parameters:' + body.toString());

    var responseJson;
    try {
      final response =
      await http.post(url, body: body, headers: Constants.headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print("responsejson" + responseJson.toString());

    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    // print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(_baseUrl + url, body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      // print('No net');
      throw FetchDataException('No Internet connection');
    }
    // print('api put.');
    // print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    // print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(_baseUrl + url);
      apiResponse = _returnResponse(response);
    } on SocketException {
      // print('No net');
      throw FetchDataException('No Internet connection');
    }
    // print('api delete.');
    return apiResponse;
  }

  dynamic _returnResponse(http.Response response) {
    var responseJson = response.body;
    // print("response :"+responseJson.toString());
    // print("responseStatusCode"+response.statusCode.toString());
    switch (response.statusCode) {
      case 409:     throw FetchDataException(
          'This information already exists on our server');
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException("an error occured"); // we will need to handle these errors well later... okieee
      case 401:
      case 403:
        throw UnauthorisedException("an error occured");
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }

  }




}