import 'package:entertainmate/screens/model/phone_check_response.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:entertainmate/screens/congrats.dart';
import 'package:entertainmate/screens/utility/complete_profile_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:entertainmate/mate.dart';

class VerifyUserProvider extends ChangeNotifier {
  String message='';
  bool loading = false;
  bool emailLoading = false;
  bool isLoadSuccessful = false;
  bool isFirstTime = false;
  String error='';
 String phone;
  bool faved = false;
  String referer='';
  String email;
  PhoneCheckResponse response;
  var context;

  Repository repository = Repository();
  CompleteProfileProvider _detailsProvider;

  Future<PhoneCheckResponse>  checkIfUserIsFirstimeUser() async {
   return repository.checkIfUserIsFirstTimeUser(phone)
        .then((wow) {
           response = wow;
           notifyListeners();
      if(response.error==false) {
        setLoading(false);
        setReferer ( response.referer );
        // set the referer for the profile provider
        _detailsProvider=
            Provider.of<CompleteProfileProvider> ( context, listen: false );
        _detailsProvider.setReferer ( response.referer );
        _detailsProvider.setIsRefered ( response.isRefered );
        _detailsProvider.setIsNameChanged ( response.isNameChanged );
        _detailsProvider.setInviteCount ( response.inviteCount );
        print("response refer"+ response.isRefered.toString());
        print("details refer"+ _detailsProvider.isRefered.toString());

        if(response.user!=null){
          _detailsProvider.setUser ( response.user );
        _detailsProvider.user.email=response.link.email;
        _detailsProvider.user.facebook=response.link.facebook;
        _detailsProvider.user.instagram=response.link.instagram;
        _detailsProvider.user.twitter=response.link.twitter;
        _detailsProvider.user.linkedin=response.link.linkedin;
        repository.loginUser ( _detailsProvider.user );
      }

      }
      // the user is a old user , which means he has registered
           bool isOldUser =response.message.toLowerCase().contains("old");
      // if user is registered i.e old and has an invite then take him to his dashboard
      if(isOldUser==true && _detailsProvider.isRefered==true ){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Mate(),
          ),
              (route) => false,
        );
      }
           if(isOldUser==true && _detailsProvider.isRefered==false ){
             Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(
                 builder: (BuildContext context) => Congrats(isOldUser:isOldUser ,referer: referer,isRefered: response.isRefered ,),
               ),
                   (route) => false,
             );
           }
      setLoading(false);
      setLoadSuccess(true);


    })
        .catchError((e) {
      setLoading(false);
      setMessage(e.toString());

      throw (e);
    });
  }
  Future<PhoneCheckResponse> checkIfUserIsFirstimeUserWithEmail() async {
  return  repository.checkIfUserIsFirstTimeUserEmail(email)
        .then((wow) {
      response = wow;
      notifyListeners();

      if(response.error==false){
        setReferer(response.referer);
        // set the referer for the profile provider
        _detailsProvider = Provider.of<CompleteProfileProvider>(context, listen: false);
        _detailsProvider.setReferer(response.referer);
        _detailsProvider.setIsRefered(response.isRefered);
        _detailsProvider.setIsNameChanged(response.isNameChanged);
        _detailsProvider.setInviteCount(response.inviteCount);
        if(response.user!=null){
        _detailsProvider.setUser(response.user);
        _detailsProvider.user.email=response.link.email;
        _detailsProvider.user.facebook=response.link.facebook;
        _detailsProvider.user.instagram=response.link.instagram;
        _detailsProvider.user.twitter=response.link.twitter;
        _detailsProvider.user.linkedin=response.link.linkedin;
        repository.loginUser(_detailsProvider.user);
        }
      }
      // the user is a old user , which means he has registered
      bool isOldUser =response.message.toLowerCase().contains("old");
      if(isOldUser==true && _detailsProvider.isRefered==true ){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Mate(),
          ),
              (route) => false,
        );
      }
      if(isOldUser==true && _detailsProvider.isRefered==false ){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Congrats(isOldUser:isOldUser ,referer: referer,isRefered: response.isRefered ,),
          ),
              (route) => false,
        );
      }
      // it is the first item we want to display
      setEmailLoading(false);
      setLoadSuccess(true);


    })
        .catchError((e) {
      setEmailLoading(false);
      setMessage(e.toString());

      throw (e);
    });
  }


  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setEmailLoading(value) {
    emailLoading = value;
    notifyListeners();
  }

  void setLoadSuccess(value) {
    isLoadSuccessful = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  bool isEmailLoading() {
    return emailLoading;
  }

  void setMessage(value) {
    message = value;
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    setLoading(false);
    notifyListeners();
  }


  String setSlug(String slug) {
    String tamedslug = slug.replaceAll("?utm_source=OneSignal&utm_medium=web-push", "");
    // print("deeplink slug"+tamedslug);

    this.referer = tamedslug;
  }


  String getMessage() {
    return message;
  }

  void setReferer(value) {
    referer  = value;
    notifyListeners();
  }
  void setPhone(value) {
    phone  = value;
    notifyListeners();
  }
  void setEmail(value) {
    email  = value;
    notifyListeners();
  }
  void setContext(value) {
    context  = value;
    notifyListeners();
  }

}
