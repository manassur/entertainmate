import 'dart:convert';

import 'package:entertainmate/screens/model/InterestedUserModel.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/model/invite_user_model.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/model/phone_check_response.dart';
import 'package:entertainmate/screens/model/save_profile_response.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constants.dart' as Constants;
import 'api_client.dart';
import 'dart:io';


class Repository {
  ApiClient _apiClient = ApiClient();
  final  httpClient = http.Client() ;

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
      'emailorphone': phone,
    };
    final response = await _apiClient.postForm(Constants.CREATE_USER,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>sendSmsInvite(String username,String name,phone,id) async {
    var body = <String, dynamic>{
      'username': username,
      'name': name,
      'phone': phone,
      'id':id
    };
    final response = await _apiClient.postForm(Constants.SEND_SMS_INVITE,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }


  Future<GenericResponse>sendEmailInvite(String id,String name,phone) async {
    var body = <String, dynamic>{
      'id': id,
      'name': name,
      'email': phone,
    };
    final response = await _apiClient.postForm(Constants.SEND_EMAIL_INVITE,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>sendEmailOtp(String email,otp) async {
    var body = <String, dynamic>{
      'otp': otp.toString(),
      'email': email,
    };
    final response = await _apiClient.postForm(Constants.SEND_EMAIL_OTP,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>updateUserDetails(User user) async {
    var body = <String, dynamic>{
      'user': jsonEncode(user),
    };
    final response = await _apiClient.postForm(Constants.UPDATE_USER_DETAILS,body);
    var data = json.decode(response);
    return  GenericResponse.fromJson(data);
  }

  Future<SaveProfileResponse>saveCompleteData(String bio,File image,String facebook,instagram,twitter,linkedin,email,username,headline,name,emailorphone) async {
    String fileInBase64;
    if(image!=null){
    List<int> fileInByte = image.readAsBytesSync();
     fileInBase64 = base64Encode(fileInByte);
   }else{ fileInBase64 = 'null';}

    var body = <String, dynamic>{
      'facebook': facebook,
      'linkedin': linkedin,
      'twitter': twitter,
      'email': email,
      'emailorphone':emailorphone,
      'instagram': instagram,
      'username':username,
      'bio': bio,
      'name':name,
      'headline':headline,
      'image': fileInBase64,
    };
    final response = await _apiClient.postForm(Constants.CHECK_SAVE_PROFILE,body);
    var data = json.decode(response);
    return  SaveProfileResponse.fromJson(data);
  }

  Future<PhoneCheckResponse>checkIfUserIsFirstTimeUser(String phone) async {
    var body = <String, dynamic>{
      'phone': phone,
    };
    final response = await _apiClient.postForm(Constants.CHECK_USER_EXIST,body);
    var data = json.decode(response);
    return  PhoneCheckResponse.fromJson(data);
  }

  Future<PhoneCheckResponse>checkIfUserIsFirstTimeUserId(String id) async {
    var body = <String, dynamic>{
      'username': id,
    };
    final response = await _apiClient.postForm(Constants.CHECK_HAS_REFERER,body);
    var data = json.decode(response);
    return  PhoneCheckResponse.fromJson(data);
  }

  Future<PhoneCheckResponse>checkIfUserIsFirstTimeUserEmail(String email) async {
    var body = <String, dynamic>{
      'email': email,
    };
    final response = await _apiClient.postForm(Constants.CHECK_EMAIL_AVAILABLE,body);
    var data = json.decode(response);
    return  PhoneCheckResponse.fromJson(data);
  }

  Future<MateHomeModel>fetchHomeFeed() async {
    final response = await _apiClient.get(Constants.FETCH_HOME_FEED);
    final data = json.decode(response);
      print("this is response feeds " + response.toString());

    return MateHomeModel.fromJson(data);
  }

  Future<FeedDetailsModel>fetchFeedDetails(postId) async {
    final response = await _apiClient.get(Constants.FETCH_FEED_DETAILS+postId);
    final data = json.decode(response);
    print("this is response feed details " + response.toString());
    return FeedDetailsModel.fromJson(data);
  }

  Future<UserCommentModel>fetchUserComments() async {
    final response = await _apiClient.get(Constants.FETCH_USER_COMMENTS);
    final data = json.decode(response);
    print("this is response user details  " + response.toString());
    return UserCommentModel.fromJson(data);
  }

  Future<InterestedUserModel>fetchInterestedUser() async {
    final response = await _apiClient.get(Constants.FETCH_INTERESTED_USER);
    final data = json.decode(response);
    print("this is response interested user  " + response.toString());
    return InterestedUserModel.fromJson(data);
  }

  Future<GenericResponse>saveInterest(String action, postId,type) async {
    var body = <String, dynamic>{
      'action': action,
      'type': type,
      'postId': postId,
    };
    final response = await _apiClient.post(Constants.SAVE_INTEREST,body);
    var data = json.decode(response);
    print("this is response save post  " + response.toString());

    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>postComment(String postId,String comment) async {
    var body = <String, dynamic>{
      'postId': postId,
      'comment': comment,
    };
    final response = await _apiClient.postForm("https://apprant.com/entertainmate/api/index.php/"+Constants.POST_COMMENT,body);
    var data = json.decode(response);
    print("comment posted successfully " + response.toString());
    return  GenericResponse.fromJson(data);
  }


  Future<GenericResponse>publishEvent(eventType,categoryId,peopleCount, title,description,location,startDate,endDate,audience,isLocationShown,isFirstInterestedAdded,List<File> images) async {
   // we have to convert each image to base64, and then convert the list to a json
    List<String> imagesInBase64 = List();
    for(var f in images){
      String fileInBase64;
      if(f!=null){
        List<int> fileInByte = f.readAsBytesSync();
        fileInBase64 = base64Encode(fileInByte);
      }else{ fileInBase64 = 'null';}
      imagesInBase64.add(fileInBase64);
    }

    var body = <String, dynamic>{
      'type':eventType.toString() ,
      'category_id': categoryId.toString(),
      'people_count':peopleCount.toString() ,
      'title': title,
      'description': description,
      'location':location ,
      'start_date': startDate,
      'end_date':endDate ,
      'audience':audience ,
      'isLocationShown': isLocationShown==true?"1":"0 ",
      'isFirstInterestedAdded':isFirstInterestedAdded==true?"1":"0",
      'images':jsonEncode(imagesInBase64).toString(),
    };
    final response = await _apiClient.postForm(Constants.CREATE_EVENT,body);
    var data = json.decode(response);
    print("event created successfully " + response.toString());
    return  GenericResponse.fromJson(data);
  }

  Future<InviteUserModel>fetchUserFollowings() async {
    final response = await _apiClient.get(Constants.FETCH_USER_FOLLOWING);
    final data = json.decode(response);
    print("this is response user following  " + response.toString());

    return InviteUserModel.fromJson(data);
  }

  SharedPreferences prefs = null;

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


  /*
  * sets user login status to true
  */
  Future<void> loginUser(User user) async {
    await openCache();
    prefs.setBool(Constants.CHECK_LOGIN_STATUS, true);
    bool loginStatus = prefs.getBool(Constants.CHECK_LOGIN_STATUS);
    print("login status:" + loginStatus.toString());
    prefs.setString(Constants.LOGGED_IN_USER, json.encode(user));
    print("login cached:" + json.encode(user));
  }

  /*
  * sets user login status to false
  */
  Future<void> logoutUser() async {
    await openCache();
    prefs.clear();
  }
  /*
  * returns the users login status
  */
  @override
  Future<bool> isLoggedIn() async {
    await openCache();
    // check if the key even exists
    bool checkValue = prefs.containsKey(Constants.CHECK_LOGIN_STATUS);

    if (checkValue) {
      bool loginStatus = prefs.getBool(Constants.CHECK_LOGIN_STATUS);
      print("isLoggedIn:" + loginStatus.toString());
      return loginStatus;
    } else {
      return false;
    }
  }

  // checks shared preferences and fetches the user data saved there
  @override
  Future<String> getSessionValue(String key) async {
    await openCache();
    String value = prefs.getString(key);
    //print("session status get:" + value);
    return value;
  }

  // checks shared preferences and fetches the user data saved there
  @override
  Future<User> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString(Constants.LOGGED_IN_USER);
    var data = json.decode(userJson);
    print("getCurrentUser:" + userJson);
    User user = User.fromJson(data);
    return user;
  }



}
