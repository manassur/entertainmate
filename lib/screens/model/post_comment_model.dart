class PostCommentModel {
  String id, creator, title, details, image, username, profile_photo;
  bool is_following;
  int members;
  int post_count;

  PostCommentModel();

  PostCommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    creator = json['creator'];
    details = json['details'];
    image = json['image'];
    members = json['members'];
    username = json['username'];
    profile_photo = json['profile_photo'];
    post_count = json['post_count'];
    is_following =json['is_following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['creator'] = this.creator;
    data['details'] = this.details;
    data['image'] = this.image;
    data['members'] = this.members;
    data['post_count'] = this.post_count;

    return data;
  }

}


// class PostCommentModel {
//   bool error;
//   int code;
//   String message;
//
//   PostCommentModel({this.error, this.code, this.message});
//
//   PostCommentModel.fromJson(Map<String, dynamic> json) {
//     error = json['error'];
//     code = json['code'];
//     message = json['message'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['error'] = this.error;
//     data['code'] = this.code;
//     data['message'] = this.message;
//     return data;
//   }
// }