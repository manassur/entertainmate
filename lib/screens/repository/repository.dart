import 'dart:convert';

import 'package:entertainmate/screens/model/InterestedUserModel.dart';
import 'package:entertainmate/screens/model/businessModel.dart';
import 'package:entertainmate/screens/model/feed_details_model.dart';
import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/model/invite_user_model.dart';
import 'package:entertainmate/screens/model/mate_home_model.dart';
import 'package:entertainmate/screens/model/old_event_model.dart';
import 'package:entertainmate/screens/model/phone_check_response.dart';
import 'package:entertainmate/screens/model/save_profile_response.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/model/user_comment.dart';
import 'package:entertainmate/screens/model/user_profile_model.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:entertainmate/screens/utility/create_event_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constants.dart' as Constants;
import 'api_client.dart';
import 'dart:io';


class Repository {

  ApiClient _apiClient = ApiClient();

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

  Future<OldEventModel>fetchOldEvent() async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_HOME_FEED);
    final data = json.decode(response);
    print("this is response feeds " + response.toString());

    return OldEventModel.fromJson(data);
  }

  Future<MateHomeModel>fetchHomeFeed(context) async {
    CompleteProfileProvider _provider = Provider.of<CompleteProfileProvider>(context, listen: false);
    var body = <String, dynamic>{
      'type': _provider.filterType,
      'category': _provider.filterCategory,
      'class': _provider.filterClass,
      'date':_provider.filterDate
    };
    final response = await _apiClient.postFormWithHeader(Constants.FETCH_HOME_FEED,body);
    final data = json.decode(response);
      print("this is response feeds " + response.toString());

    return MateHomeModel.fromJson(data);
  }

  Future<MateHomeModel>fetchDealsFeed() async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_DEALS_FEED);
    final data = json.decode(response);
    print("this is response feeds " + response.toString());

    return MateHomeModel.fromJson(data);
  }

  Future<FeedDetailsModel>fetchFeedDetails(postId,branch) async {

    final response = await _apiClient.getWithHeader(branch==0?Constants.FETCH_FEED_DETAILS+postId:Constants.FETCH_DEALS_DETAILS+postId);
    final data = json.decode(response);
    print("this is response feed details " + response.toString());
    return FeedDetailsModel.fromJson(data);
  }

  Future<UserProfileModel>fetchUserProfile(userId) async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_USER_PROFILE+userId);
    final data = json.decode(response);
    print("this is response user profile " + response.toString());
    return UserProfileModel.fromJson(data);
  }

  Future<UserCommentModel>fetchUserComments(String postId) async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_USER_COMMENTS+postId);
    final data = json.decode(response);
    print("this is response user comment  " + response.toString());
    return UserCommentModel.fromJson(data);
  }

  Future<InterestedUserModel>fetchInterestedUser(String userId) async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_INTERESTED_USER+userId);
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
    final response = await _apiClient.postFormWithHeader(Constants.SAVE_INTEREST,body);
    var data = json.decode(response);
    print("this is response save post  " + response.toString());

    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>saveInterestAdmin(String action, postId,type,userId) async {
    var body = <String, dynamic>{
      'action': action,
      'type': type,
      'postId': postId,
      'userId':userId
    };
    final response = await _apiClient.postFormWithHeader(Constants.SAVE_INTEREST_ADMIN,body);
    var data = json.decode(response);
    print("this is response save post  " + response.toString());

    return  GenericResponse.fromJson(data);
  }



  Future<GenericResponse>followUser(String userId,int action)async{
    String endPoint = action == 1? Constants.UNFOLLOW_USER : Constants.FOLLOW_USER;
      var body = <String, dynamic>{
        'user_id' : userId,
      };
      final response = await _apiClient.postFormWithHeader(endPoint, body);
      var data = json.decode(response);
      print("follow users  " + response.toString());

    return GenericResponse.fromJson(data);
  }



  Future<GenericResponse>postComment(String postId,String comment) async {
    var body = <String, dynamic>{
      'postId': postId,
      'comment': comment,
    };
    final response = await _apiClient.postFormWithHeader(Constants.POST_COMMENT,body);
    var data = json.decode(response);
    print("comment posted successfully " + response.toString());
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>registerBusiness(String name, String type, String description, String slogan,String phone, String email, String location, String time, String website, String more,File f)
   async {
     List<int> fileInByte = f.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    var body = <String, dynamic>{
      'name': name,
      'type': type,
      'tags': description,
      'slogan': slogan,
      'phone': phone,
      'email': email,
      'location': location,
      'hours': time,
      'website': website,
      'description': more,
      'instagram':'',
      'facebook':'',
      'linkedin':'',
      'photo':jsonEncode(fileInBase64).toString(),
      'role':''

    };

    final response = await _apiClient.postFormWithHeader(Constants.REGISTER_BUSINESS,body);
    var data = json.decode(response);
    print("Business registered successfully " + response.toString());
    return  GenericResponse.fromJson(data);
  }


  Future<GenericResponse>publishEvent(busid,branch,eventType,categoryId,peopleCount, title,description,location,startDate,endDate,audience,isLocationShown,isFirstInterestedAdded,List<File> images) async {
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
      'branch':branch.toString(),
      'type':eventType.toString() ,
      'category_id': categoryId.toString(),
      'people_count':peopleCount.toString() ,
      'title': title,
      'description': description,
      'location':location ,
      'start_date': startDate,
      'end_date':endDate ,
      'audience':audience.toString() ,
      'isLocationShown': isLocationShown==true?"1":"0 ",
      'isFirstInterestedAdded':busid.toString(),
      'images':jsonEncode(imagesInBase64).toString(),
    };
    final response = await _apiClient.postFormWithHeader(Constants.CREATE_EVENT,body);
    var data = json.decode(response);
    print("event created successfully " + response.toString());
    return  GenericResponse.fromJson(data);
  }

  Future<GenericResponse>postImage(postId,List<File> images) async {
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
      'post_id': postId,
      'images':jsonEncode(imagesInBase64).toString(),
    };
    final response = await _apiClient.postFormWithHeader(Constants.CREATE_POST_IMAGE,body);
    var data = json.decode(response);
    print("event created successfully " + response.toString());
    return  GenericResponse.fromJson(data);
  }


  Future<InviteUserModel>fetchUserFollowings(String event, String id) async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_USER_FOLLOWING);
    final data = json.decode(response);
    print("this is response user following  " + response.toString());

    return InviteUserModel.fromJson(data);
  }

  Future<BusinessModel>fetchUserBusiness() async {
    final response = await _apiClient.getWithHeader(Constants.FETCH_USER_BUSINESS);
    final data = json.decode(response);
    print("this is user business response  " + response.toString());
    return BusinessModel.fromJson(data);
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
