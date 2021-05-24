import 'dart:convert';

import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constants.dart' as Constants;
import 'api_client.dart';


class Repository {
  ApiClient _apiClient = ApiClient();
  final  httpClient = http.Client() ;

//  Future<LatestNewsResponse>fetchSingleNews(String slug) async {
//    final response = await _apiClient.get(Constants.SINGLE_NEWS+slug);
//    var data = json.decode(response);
//    return  LatestNewsResponse.fromJson(data);
//  }

    Future<GenericResponse>checkIfUsernameIsAvailaible(String username) async {
    final response = await _apiClient.get(Constants.SINGLE_NEWS+username);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  SharedPreferences prefs= null;

  void openCache() async {
    prefs =  await SharedPreferences.getInstance();
  }

  /*
   * caches any string and key
   */
  void saveAnyStringToCache(String value,String key) async {
    await openCache();
    // check if the key even exists
    prefs.setString(key,value);
  }

  // checks shared preferences and fetches the  data saved there
  @override
  Future<String> getAnyStringValueFromCache(String key) async {
    await openCache();
    String value = prefs.getString(key);
    return value;
  }





//  @override
//  Future<NetCoreResponse> subscribeToNewsLetter(String email) async{
//    var body =  {
//      'data':"{\"EMAIL\":\""+email+"\"}",
//    };
//    final response = await _apiClient.post(Constants.netCoreUrl, body);
//    final json = jsonDecode(response);
//    return NetCoreResponse.fromJson(json);
//
//  }



}
