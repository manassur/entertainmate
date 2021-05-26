import 'package:entertainmate/screens/model/phone_check_response.dart';
import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:entertainmate/screens/congrats.dart';


class VerifyUserProvider extends ChangeNotifier {
  String message;
  bool loading = false;
  bool isLoadSuccessful = false;
  bool isFirstTime = false;
  String error='';
 String phone;
  bool faved = false;
  String referer='';
  PhoneCheckResponse response;
  var context;

  Repository repository = Repository();

  checkIfUserIsFirstimeUser() async {
    setMessage("");
    repository.checkIfUserIsFirstTimeUser(phone)
        .then((wow) {
           response = wow;
      if(response.isRefered){
        setReferer(response.referer);
      }

      if(response.message.toLowerCase().contains("old")){
        Navigator.push(context,    MaterialPageRoute(builder: (context) => Congrats(referer: referer,isRefered: response.isRefered ,)));
      }

   // it is the first item we want to display
      setLoading(false);
      setLoadSuccess(true);


    })
        .catchError((e) {
      setLoading(false);

      throw (e);
    });
  }


  void setLoading(value) {
    loading = value;
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
  void setContext(value) {
    context  = value;
    notifyListeners();
  }

}
