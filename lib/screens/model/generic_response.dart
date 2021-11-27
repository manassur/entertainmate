class GenericResponse {
  String message;
  bool error;
  String code;
  // this is a class function
  GenericResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    code =json['code'].toString();
  }
}
