import 'dart:convert';

import 'package:entertainmate/screens/congrats.dart';
import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utility/constants.dart' as Constants;
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:entertainmate/screens/verify_email//otp.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';

import '../../mate.dart';

class CreateEventProvider extends ChangeNotifier {
  int eventType=0,categoryId=0,peopleCount=0;
  String title='',description='',location='',startDate='',endDate='',audience='',categoryName='',peopleCountText='';
  bool isLocationShown=false,isFirstInterestedAdded=false;
  List<File> images = List();

  void setEventType(value) {
    eventType = value;
    notifyListeners();
  }

  void setCategoryId(value) {
    categoryId  = value;
    notifyListeners();
  }

  void setAudience(value) {
   audience  = value;
    notifyListeners();
  }

  void setPeopleCount(value) {
    peopleCount= int.parse(value);
    notifyListeners();
  }

  void setTitle(value) {
   title = value;
    notifyListeners();
  }
  void setDescription(value) {
  description  = value;
    notifyListeners();
  }
  void setLocation(value) {
    location = value;
    notifyListeners();
  }
  void setStartDate(value) {
    startDate= value;
    notifyListeners();
  }
  void setEndDate(value) {
   endDate = value;
    notifyListeners();
  }

  void setCategoryName(value) {
   categoryName = value;
    notifyListeners();
  }

  void setLocationShown(value) {
    isLocationShown = value;
    notifyListeners();
  }

  void setFirstInterestedAdded(value) {
    isFirstInterestedAdded = value;
    notifyListeners();
  }

  void addImage(value) {
    images.add(value);
    notifyListeners();
  }

// value in this case is the index
  void removeImage(value) {
    images.removeAt(value);
    notifyListeners();
  }

//  bool isLoading() {
//    return loading;
//  }


}
