
class User {
  bool error;
  String id,username,firstname,lastname,api,headline,bio;
  String facebook,instagram,email,twitter,linkedin;

  String gender,referer='';
  bool isVerified,isNameChanged=false;
  String isDisabled,profilePhoto='';
  int invites;


  User();
  // this is a class function
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headline = json['headline'];
    bio = json['bio'];
    referer = json['referer'];
    username = json['username'];
    firstname = json['firstname'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    email = json['email'];
    linkedin = json['linkedin'];
    facebook = json['facebook'];
    invites = json['invites'];
    isNameChanged = json['isNameChanged'];
    profilePhoto = json['profilePhoto'];
    isVerified = json['isVerified'];
    invites = json['invites'];
    api = json['api'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   // data['api'] = this.api;
    data['id'] =this.id;
    data['headline'] =this.headline;
    data['referer'] =this.referer;
    data['isNameChanged'] =this.isNameChanged;
    data['bio'] =this.bio;
    data['username'] =this.username;
    data['firstname'] = this.firstname ;
    data['instagram'] = this.instagram ;
    data['twitter'] = this.twitter ;
    data['email'] = this.email ;
    data['linkedin'] = this.linkedin ;
    data['facebook'] = this.facebook ;
    data['isVerified'] = this.isVerified ;
    data['profilePhoto'] = this.profilePhoto ;
    data['invites'] = this.invites ;
    data['api'] = this.api;


//    data['isVerified'] =this.isVerified ;
//    data['isDisabled'] =this. isDisabled ;

    return data;
  }

}