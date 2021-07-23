class InterestedUserModel {
  String id;
  String username;
  String name;
  Null email;
  String phone;
  String headline;
  Null bio;
  bool isVerified;
  String isDisabled;
  String location;
  String profilePhoto;
  String description;
  String createdAt;
  Link link;
  Relation relation;
  bool error;

  InterestedUserModel(
      {this.id,
        this.username,
        this.name,
        this.email,
        this.phone,
        this.headline,
        this.bio,
        this.isVerified,
        this.isDisabled,
        this.location,
        this.profilePhoto,
        this.description,
        this.createdAt,
        this.link,
        this.relation,
        this.error});

  InterestedUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    headline = json['headline'];
    bio = json['bio'];
    isVerified = json['isVerified'];
    isDisabled = json['isDisabled'];
    location = json['location'];
    profilePhoto = json['profilePhoto'];
    description = json['description'];
    createdAt = json['created_At'];
    link = json['link'] != null ? new Link.fromJson(json['link']) : null;
    relation = json['relation'] != null
        ? new Relation.fromJson(json['relation'])
        : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['headline'] = this.headline;
    data['bio'] = this.bio;
    data['isVerified'] = this.isVerified;
    data['isDisabled'] = this.isDisabled;
    data['location'] = this.location;
    data['profilePhoto'] = this.profilePhoto;
    data['description'] = this.description;
    data['created_At'] = this.createdAt;
    if (this.link != null) {
      data['link'] = this.link.toJson();
    }
    if (this.relation != null) {
      data['relation'] = this.relation.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Link {
  String facebook;
  String twitter;
  String instagram;
  String email;
  String linkedin;

  Link(
      {this.facebook, this.twitter, this.instagram, this.email, this.linkedin});

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

class Relation {
  int isFollowed;
  int isFollowing;

  Relation({this.isFollowed, this.isFollowing});

  Relation.fromJson(Map<String, dynamic> json) {
    isFollowed = json['isFollowed'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isFollowed'] = this.isFollowed;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}