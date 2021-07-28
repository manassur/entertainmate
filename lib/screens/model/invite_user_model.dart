class InviteUserModel {
  bool error;
  bool isSelected;
  List<Followers> followers;

  InviteUserModel({this.error, this.followers});

  InviteUserModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    isSelected = false;
    if (json['followers'] != null) {
      followers = new List<Followers>();
      json['followers'].forEach((v) {
        followers.add(new Followers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.followers != null) {
      data['followers'] = this.followers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followers {
  String id;
  String name;
  String icon;
  String creation;
  String location;
  String isVerified;
  bool isSelected;

  Followers(
      {this.id,
        this.name,
        this.icon,
        this.creation,
        this.location,
        this.isVerified,
      this.isSelected});

  Followers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    creation = json['creation'];
    location = json['location'];
    isVerified = json['isVerified'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['creation'] = this.creation;
    data['location'] = this.location;
    data['isVerified'] = this.isVerified;
    return data;
  }
}