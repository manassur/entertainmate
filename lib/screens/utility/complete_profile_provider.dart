import 'package:entertainmate/screens/model/generic_response.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CompleteProfileProvider extends ChangeNotifier {
  PageController controller = PageController();

  int currentPage=0;
  String message='';
  bool loading = false;  bool saveLoading = false; bool saveCompleteLoading = false;

  bool isLoadSuccessful = false;
  bool isUsernameAvailable = false;
  String error='';

  bool faved = false;
  String username,name,headline,phone='',bio='',facebook='',instagram='',linkedin='',twitter='',email='';
  File image;
  User user;
  GenericResponse response; GenericResponse saveResponse;
  Repository repository = Repository();

  checkIfUsernameIsAvailable() async {
    setMessage("");
    setLoading(true);

    repository.checkIfUsernameIsAvailaible(username)
        .then((wow) {
          response = wow;
          if(response.error==false){
            setUsernameAvailable(true);
            setMessage(response.message); // it is the first item we want to display

          }
      setLoading(false);
      setLoadSuccess(true);

    })
        .catchError((e) {
      setLoading(false);

      throw (e);
    });
  }

  saveNames() async {
    setMessage("");
    setSaveNameLoading(true);

    repository.saveUserNames(username,name,headline,phone)
        .then((wow) {
      response = wow;
      if(response.error==false){
       // setMessage(response.message); // it is the first item we want to display
        setCurrentPage(1);
      }
      setSaveNameLoading(false);
    //  setLoadSuccess(true);

    })
        .catchError((e) {
      setSaveNameLoading(false);

      throw (e);
    });
  }
  saveCompleteData() async {
    setMessage("");
    setSaveCompleteLoading(true);
    repository.saveCompleteData( bio, image, facebook,instagram,twitter,linkedin,email,username)
        .then((wow) {
      response = wow;
      if(response.error==false){
        // setMessage(response.message); // it is the first item we want to display

      }
      setSaveCompleteLoading(false);
      //  setLoadSuccess(true);

    })
        .catchError((e) {
      setSaveCompleteLoading(false);

      throw (e);
    });
  }


  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setSaveNameLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setSaveCompleteLoading(value) {
    saveCompleteLoading = value;
    notifyListeners();
  }


  void setLoadSuccess(value) {
    isLoadSuccessful = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setMessage(value) {
    message = value;
//    Fluttertoast.showToast(
//      msg: value,
//      toastLength: Toast.LENGTH_SHORT,
//      timeInSecForIosWeb: 1,
//    );
    notifyListeners();
  }
  String setSlug(String slug) {
    String tamedslug = slug.replaceAll("?utm_source=OneSignal&utm_medium=web-push", "");
    // print("deeplink slug"+tamedslug);

    this.username = tamedslug;
  }


  String getMessage() {
    return message;
  }

  void setUsername(value) {
    username  = value;
    notifyListeners();
  }
  void setName(value) {
    name  = value;
    notifyListeners();
  }
  void setHeadline(value) {
    headline  = value;
    notifyListeners();
  }

  void setPhone(value) {
    phone  = value;
    notifyListeners();
  }

  User getNewsDetails() {
    return user;
  }

  void setUsernameAvailable(value) {
    isUsernameAvailable  = value;
    notifyListeners();
  }

  void setBio(value) {
    bio  = value;
    notifyListeners();
  }

  void setFile(value) {
    image  = value;
    notifyListeners();
  }

  void setLinks(v1,v2,v3,v4,v5) {
    facebook  = v1;
    instagram = v2;
    twitter = v3;
    linkedin = v4;
    email = v5;
    notifyListeners();
  }

  void setCurrentPage(value) {

    currentPage  = value;
    controller.jumpToPage(currentPage);
    notifyListeners();
  }
}
