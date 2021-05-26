class PhoneCheckResponse {
  String message;
  bool error,isRefered;
  String referer;
  // this is a class function
  PhoneCheckResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    isRefered = json['isRefered'];
    if(isRefered == true){
      referer = json['referer'];
    }
  }
}
