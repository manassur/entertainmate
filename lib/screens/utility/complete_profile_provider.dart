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

class CompleteProfileProvider extends ChangeNotifier {
  PageController controller = PageController();

  int currentPage=0;
  String message='';
  bool loading = false;  bool saveLoading = false; bool saveCompleteLoading = false;

  bool isLoadSuccessful = false;
  bool isUsernameAvailable = false;
  bool userUpdateLoading = false;
  String error='',referer='';
  bool isRefered = false;
  var context;
  bool isNameChanged = false;

  //sms invite variables
  String smsInviteMessage='';
  bool smsInviteLoading=false;
  //sms invite variables
  String emailInviteMessage='';
  bool emailInviteLoading=false;
  // email otp
  //sms invite variables
  String emailOtpMessage='';
  bool emailOtpLoading=false;
  bool faved = false;
  String username='',name='',headline='',phone='',bio='',facebook='',instagram='',linkedin='',twitter='',email='',profilePhoto='';
  File image;
  Repository _userRepository;
  User user = User();
  GenericResponse response; GenericResponse saveResponse;
  Repository repository = Repository();

  checkIfUsernameIsAvailable() async {
    setLoading(true);

    repository.checkIfUsernameIsAvailaible(username)
        .then((wow) {
          response = wow;
          if(response.error==false){
            setUsernameAvailable(true);
            setMessage(response.message); // it is the first item we want to display
          }else{
            setUsernameAvailable(false);
            setMessage(response.message);

          }

      setLoading(false);
      setLoadSuccess(true);

      notifyListeners();

    })
        .catchError((e) {
      setLoading(false);

      throw (e);
    });
  }

  saveNames() async {
    //setMessage("");
   // setSaveNameLoading(true);
    setCurrentPage(1);
//
//    repository.saveUserNames(username,name,headline,phone)
//        .then((wow) {
//      response = wow;
//      if(response.error==false){
//       // setMessage(response.message); // it is the first item we want to display
//        setCurrentPage(1);
//      }
//      setSaveNameLoading(false);
//    //  setLoadSuccess(true);
//
//    })
//        .catchError((e) {
//      setSaveNameLoading(false);
//
//      throw (e);
//    });
  }
  saveCompleteData() async {
    setMessage("");
    setSaveCompleteLoading(true);
    repository.saveCompleteData( bio, image, facebook,instagram,twitter,linkedin,email,username,headline,name,phone)
        .then((wow) {
      if(wow.error==false){
        // setMessage(response.message); // it is the first item we want to display
        setProfilePhoto(wow.profilePhoto);

        // create the user
        User user = User();
        user.username=username;
        user.firstname=name;
        user.profilePhoto = profilePhoto;
        user.id= wow.id;
        user.facebook = facebook;
        user.email = email;
        user.linkedin = linkedin;
        user.instagram = instagram;
        user.twitter = twitter;
        user.isVerified = isRefered;
        user.referer = referer;
        user.bio = bio;
        user.headline = headline;



        setUser(user);


        if(isRefered==true){ // this should be changed to true
          //ony log in the user when he isi referred
          Repository rep = Repository();
          rep.loginUser(user);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>Mate(),
            ),
                (route) => false,
          );        }else{
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Congrats(referer: referer,isRefered: isRefered,),
            ),
                (route) => false,
          );
        }
      }
      setSaveCompleteLoading(false);
      //  setLoadSuccess(true);

    })
        .catchError((e) {
      setSaveCompleteLoading(false);

      throw (e);
    });
  }
  setUser(data) async{
   user = data;
    notifyListeners();
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

  // sms invite things
  bool isSmsInviteLoading() {
    return smsInviteLoading;
  }
  void setSmsInviteLoading(value) {
    smsInviteLoading = value;
    notifyListeners();
  }
  sendSmsInvite(to) async {
    setSmsInviteLoading(true);

    repository.sendSmsInvite(user.username,user.firstname,to,user.id)
        .then((wow) {
      response = wow;
      if(response.error==false){
        setSmsInviteMessage(response.message); // it is the first item we want to display
        // reduce the user invites
        if(user.invites<5){
          user.invites++;
        }
      }
      setSmsInviteLoading(false);

    })
        .catchError((e) {
      setSmsInviteLoading(false);

      throw (e);
    });
  }
  void setSmsInviteMessage(value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    smsInviteMessage = value;
    notifyListeners();
  }

  // sms invite things
  bool isEmailInviteLoading() {
    return emailInviteLoading;
  }

  void setEmailInviteLoading(value) {
    emailInviteLoading = value;
    notifyListeners();
  }

  sendEmailInvite(to) async {
    setEmailInviteLoading(true);

    repository.sendEmailInvite(user.id,user.firstname,to)
        .then((wow) {
      response = wow;
      if(response.error==false){
        // reduce the user invites
        if(user.invites<5){
          user.invites++;
        }
        setEmailInviteMessage(response.message); // it is the first item we want to display
      }else{
        setEmailInviteMessage("could not invite user at this time, try again later");
      }
      setEmailInviteLoading(false);

    })
        .catchError((e) {
      setEmailInviteLoading(false);

      throw (e);
    });
  }

  sendEmailOtp(to,ctx) async {
    setEmailOtpLoading(true);
    Random random = new Random();
    int randomNumber = random.nextInt(100000) + 900000; // f
    print("otp : "+randomNumber.toString());
    repository.sendEmailOtp(to,randomNumber)
        .then((wow) {
      response = wow;
      if(response.error==false){
        // reduce the user invites
        setEmailOtpMessage(response.message); // it is the first item we want to display
        Navigator.pop(ctx);
        Navigator.push(ctx,MaterialPageRoute(builder: (context) => Otp(email:to,smsOTP: randomNumber.toString(),)));


      }else{
        setEmailOtpMessage("could not send otp at this time, try again later");
      }
      setEmailOtpLoading(false);

    })
        .catchError((e) {
      setEmailOtpLoading(false);

      throw (e);
    });
  }
  // sms invite things
  bool isUserUpdateLoading() {
    return userUpdateLoading;
  }
  void setUserUpdateMessage(value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    smsInviteMessage = value;
    notifyListeners();
  }

  void setUserUpdateLoading(value) {
    userUpdateLoading = value;
    notifyListeners();
  }

  // sms invite things
  bool isEmailOtpLoading() {
    return emailOtpLoading;
  }
  void setEmailOtpMessage(value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    emailOtpMessage = value;
    notifyListeners();
  }

  void setEmailOtpLoading(value) {
    emailOtpLoading = value;
    notifyListeners();
  }


  updateUserDetails(String _nameCon ,
      String _headlineCon,
      String _bioCon ,
      String _faceCon ,
      String _insCon ,
      String _twiCon,String _linCon ,String _mailCon) async {
    setUserUpdateLoading(true);

    // check for those that are not empty and populate
    User newUser = user;
    //check if a name change is included
    if(newUser.firstname != _nameCon){
      newUser.isNameChanged=true;
    }
    newUser.firstname = _nameCon.isNotEmpty?_nameCon:user.firstname;
    newUser.headline = _headlineCon.isNotEmpty?_headlineCon:user.headline;
    newUser.bio = _bioCon.isNotEmpty?_bioCon:user.bio;
    newUser.facebook = _faceCon.isNotEmpty?_faceCon:user.facebook;
    newUser.instagram = _insCon.isNotEmpty?_insCon:user.instagram;
    newUser.twitter = _twiCon.isNotEmpty?_twiCon:user.twitter;
    print("twiitter culpruit : "+_twiCon);
    newUser.linkedin = _linCon.isNotEmpty?_linCon:user.linkedin;
    newUser.email = _mailCon.isNotEmpty?_mailCon:user.email;

    print("new user" +jsonEncode(newUser));




    repository.updateUserDetails(newUser)
        .then((wow) {
      response = wow;
      if(response.error==false){
        // reduce the user invites
       setUserUpdateMessage(response.message); // it is the first item we want to display
       setUserUpdateLoading(false);
       setUser(newUser);

      }else{
        setUserUpdateMessage("could not update your details at this time, try again later");
      }
      setUserUpdateLoading(false);

    })
        .catchError((e) {
    setUserUpdateLoading(false);
      throw (e);
    });
  }


  void setEmailInviteMessage(value) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    emailInviteMessage = value;
    notifyListeners();
  }


  // others
  void setMessage(value) {
    message = value;
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

  void setProfilePhoto(value) {
    profilePhoto  = value;
    notifyListeners();
  }


  void setReferer(value) {
    referer  = value;
    notifyListeners();
  }

  void setIsRefered(value) {
    isRefered  = value;
    notifyListeners();
  }
  void setIsNameChanged(value) {
    user.isNameChanged=value;
    isNameChanged  = value;
    notifyListeners();
  }
  void setInviteCount(value) {
    user.invites=value;
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

  void setContext(value) {
    context  = value;
    notifyListeners();
  }
}
