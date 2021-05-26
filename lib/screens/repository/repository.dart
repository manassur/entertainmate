import 'dart:convert';

import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/model/phone_check_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constants.dart' as Constants;
import 'api_client.dart';
import 'dart:io';


class Repository {
  ApiClient _apiClient = ApiClient();
  final  httpClient = http.Client() ;

//  Future<LatestNewsResponse>fetchSingleNews(String slug) async {
//    final response = await _apiClient.get(Constants.SINGLE_NEWS+slug);
//    var data = json.decode(response);
//    return  LatestNewsResponse.fromJson(data);
//  }

    Future<GenericResponse>checkIfUsernameIsAvailaible(String username) async {
      var body = <String, dynamic>{
        'username': username,
      };
    final response = await _apiClient.postForm(Constants.CHECK_USERNAME_AVAILABLE,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>saveUserNames(String username,String name,String headline,phone) async {
    var body = <String, dynamic>{
      'username': username,
      'name': name,
      'headline': headline,
      'phone': phone,
    };
    final response = await _apiClient.postForm(Constants.CREATE_USER,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>saveCompleteData(String bio,File image,String facebook,instagram,twitter,linkedin,email,username) async {
    List<int> fileInByte = image.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);

    var body = <String, dynamic>{
      'bio': bio,
      'image': fileInBase64,
      'facebook': facebook,
      'linkedin': linkedin,
      'twitter': twitter,
      'email': email,
      'instagram': instagram,
      'username':username

    };
    final response = await _apiClient.postForm(Constants.CHECK_SAVE_PROFILE,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }


  Future<PhoneCheckResponse>checkIfUserIsFirstTimeUser(String phone) async {
    var body = <String, dynamic>{
      'phone': phone,
    };
    final response = await _apiClient.postForm(Constants.CHECK_USER_EXIST,body);
    var data = json.decode(response);
    return  PhoneCheckResponse.fromJson(data);
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
