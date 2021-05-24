
class User {
  bool error;
  String id,username,firstname,lastname,api;
  String gender,isVerified;
  String isDisabled,profilePhoto;


  // this is a class function
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    api = json['api'];
    username = json['middlename'];
    firstname = json['firstname'];
    lastname = json['lastname'];
//    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api'] = this.api;
    data['id'] =this.id;
    data['middlename'] =this.username;
    data['firstname'] = this.firstname ;
    data['lastname'] =this.lastname ;
    data['sex'] =this.gender ;
//    data['isVerified'] =this.isVerified ;
//    data['isDisabled'] =this. isDisabled ;

    return data;
  }

}