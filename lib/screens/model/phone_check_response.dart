
import 'link.dart';
import 'user.dart';

class PhoneCheckResponse {
  String message='';
  bool error,isRefered;
  String referer;
  int inviteCount;
  bool isNameChanged=false;
  User user;
  Link link;

  // this is a class function
  PhoneCheckResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    isRefered = json['isRefered'];
      referer = json['referer'];
    isNameChanged = json['isNameChanged'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if(user!=null) {
      user.isNameChanged=isNameChanged;
      user.isVerified = isRefered;
    }
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
  }
}
