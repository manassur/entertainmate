import 'package:entertainmate/screens/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constants.dart' as Constants;


import 'package:flutter/services.dart'; // is required
import 'dart:convert';

class CacheRepository{
  SharedPreferences prefs= null;
  void openCache() async {
     prefs =  await SharedPreferences.getInstance();
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