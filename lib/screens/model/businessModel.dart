class BusinessModel {
  bool error;
  List<Business> business;

  BusinessModel({this.error, this.business});

  BusinessModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['business'] != null) {
      business = new List<Business>();
      json['business'].forEach((v) {
        business.add(new Business.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.business != null) {
      data['business'] = this.business.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Business {
  String id;
  String name;
  String type;
  String tags;
  String slogan;
  String phone;
  String email;
  String location;
  String hours;
  String website;
  String description;
  String photo;
  String instagram;
  String facebook;
  String linkedin;
  String createdBy;
  String createdOn;
  String updatedOn;
  String status;
  List<Staff> staff;

  Business(
      {this.id,
        this.name,
        this.type,
        this.tags,
        this.slogan,
        this.phone,
        this.email,
        this.location,
        this.hours,
        this.website,
        this.description,
        this.photo,
        this.instagram,
        this.facebook,
        this.linkedin,
        this.createdBy,
        this.createdOn,
        this.updatedOn,
        this.status,
        this.staff});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    tags = json['tags'];
    slogan = json['slogan'];
    phone = json['phone'];
    email = json['email'];
    location = json['location'];
    hours = json['hours'];
    website = json['website'];
    description = json['description'];
    photo = json['photo'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    linkedin = json['linkedin'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    status = json['status'];
    if (json['staff'] != null) {
      staff = new List<Staff>();
      json['staff'].forEach((v) {
        staff.add(new Staff.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['tags'] = this.tags;
    data['slogan'] = this.slogan;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['location'] = this.location;
    data['hours'] = this.hours;
    data['website'] = this.website;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['linkedin'] = this.linkedin;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['status'] = this.status;
    if (this.staff != null) {
      data['staff'] = this.staff.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Staff {
  String id;
  String name;
  String profilePhoto;
  String role;

  Staff({this.id, this.name, this.profilePhoto, this.role});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePhoto = json['profilePhoto'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profilePhoto'] = this.profilePhoto;
    data['role'] = this.role;
    return data;
  }
}
