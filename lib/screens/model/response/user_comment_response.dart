
import 'package:entertainmate/screens/model/user_comment.dart';


// class UserCommentResponse {
//   List<UserCommentModel> userComments;
//
//   UserCommentResponse({this.userComments});
//
//   UserCommentResponse.fromJson(List<dynamic> json) {
//     //page = json['page'];
//     if (json != null) {
//       userComments = new List<UserCommentModel>();
//       json.forEach((v) {
//         userComments.add(new UserCommentModel.fromJson(v));
//       });
//     }
//   }
//
//   String toJson() {
//       String data;
//      // data['page'] = this.page;
//      if (this.userComments != null) {
//        data = this.userComments.map((v) => v.toJson()).toList().toString();
//      }
//      return data;
//    }
// }

class UserCommentResponse {
  // int page;
  List<UserCommentModel> userComments;

  UserCommentResponse({
    // this.page,
    this.userComments
  });

  UserCommentResponse.fromJson(List<dynamic> json) {
    //page = json['page'];
    if (json != null) {
      userComments = new List<UserCommentModel>();
      json.forEach((v) {
        userComments.add(new UserCommentModel.fromJson(v));
      });
    }
  }

  String toJson() {
    String data;
    // data['page'] = this.page;
    if (this.userComments != null) {
      data = this.userComments.map((v) => v.toJson()).toList().toString();
    }
    return data;
  }

}