import 'package:entertainmate/screens/model/user.dart';
import 'package:entertainmate/screens/repository/repository.dart';
import 'package:flutter/foundation.dart';


class CompleteProfileProvider extends ChangeNotifier {
  String message;
  bool loading = true;
  bool isLoadSuccessful = false;
  bool isUsernameAvailable = false;
  String error='';

  bool faved = false;
  String username;
  User user;

  Repository repository = Repository();

  checkIfUsernameIsAvailable() async {
    setMessage("");
    repository.checkIfUsernameIsAvailaible(username)
        .then((wow) {
      setUsername(wow.error); // it is the first item we want to display
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

    this.username = tamedslug;
  }


  String getMessage() {
    return message;
  }

  void setUsername(value) {
    isUsernameAvailable  = value;
    notifyListeners();
  }

  User getNewsDetails() {
    return user;
  }
}
