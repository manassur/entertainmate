class Link {
  String facebook;
  String twitter;
  String instagram;
  String email;
  String linkedin;


  Link.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    email = json['email'];
    linkedin = json['linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['email'] = this.email;
    data['linkedin'] = this.linkedin;
    return data;
  }
}
