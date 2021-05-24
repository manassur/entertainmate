import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constants.dart' as Constants;


import 'package:flutter/services.dart'; // is required
import 'dart:convert';

class CacheRepository{
  SharedPreferences prefs= null;
  void openCache() async {
     prefs =  await SharedPreferences.getInstance();
  }


}