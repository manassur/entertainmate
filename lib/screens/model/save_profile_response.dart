class SaveProfileResponse {
  String message;
  bool error;
  String profilePhoto,id;
  // this is a class function
  SaveProfileResponse.fromJson(Map<String, dynamic> json) {
  //  message = json['message'];
    error = json['error'];
    profilePhoto = json['profilePhoto'];
    id = json['id'];

  }
}
