class MateHomeModel {
  bool error;
  List<Feeds> feeds;

  MateHomeModel({this.error, this.feeds});

  MateHomeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['feeds'] != null) {
      feeds = new List<Feeds>();
      json['feeds'].forEach((v) {
        feeds.add(new Feeds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.feeds != null) {
      data['feeds'] = this.feeds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feeds {
  String userId;
  String username;
  String name;
  String description;
  String profilePhoto;
  String isVerified;
  Post post;

  Feeds(
      {this.userId,
        this.username,
        this.name,
        this.description,
        this.profilePhoto,
        this.isVerified,
        this.post});

  Feeds.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    name = json['name'];
    description = json['description'];
    profilePhoto = json['profilePhoto'];
    isVerified = json['isVerified'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['description'] = this.description;
    data['profilePhoto'] = this.profilePhoto;
    data['isVerified'] = this.isVerified;
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}

class Post {
  String postId;
  String type;
  String content;
  String description;
  String creation;
  String categoryId;
  String categoryName;
  String status;
  int availableSeats;
  int occupiedSeats;
  String audience;
  int saves;
  int interests;
  int going;
  int comments;
  String startDate;
  String endDate;
  List<GoingUsers> goingUsers;

  Post(
      {this.postId,
        this.type,
        this.content,
        this.description,
        this.creation,
        this.categoryId,
        this.categoryName,
        this.status,
        this.availableSeats,
        this.occupiedSeats,
        this.audience,
        this.saves,
        this.interests,
        this.going,
        this.comments,
        this.startDate,
        this.endDate,
        this.goingUsers});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    type = json['type'];
    content = json['content'];
    description = json['description'];
    creation = json['creation'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    status = json['status'];
    availableSeats = json['available_seats'];
    occupiedSeats = json['occupied_seats'];
    audience = json['audience'];
    saves = json['saves'];
    interests = json['interests'];
    going = json['going'];
    comments = json['comments'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    if (json['going_users'] != null) {
      goingUsers = new List<GoingUsers>();
      json['going_users'].forEach((v) {
        goingUsers.add(new GoingUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['type'] = this.type;
    data['content'] = this.content;
    data['description'] = this.description;
    data['creation'] = this.creation;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['status'] = this.status;
    data['available_seats'] = this.availableSeats;
    data['occupied_seats'] = this.occupiedSeats;
    data['audience'] = this.audience;
    data['saves'] = this.saves;
    data['interests'] = this.interests;
    data['going'] = this.going;
    data['comments'] = this.comments;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.goingUsers != null) {
      data['going_users'] = this.goingUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoingUsers {
  String id;
  String profilePhoto;

  GoingUsers({this.id, this.profilePhoto});

  GoingUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profilePhoto'] = this.profilePhoto;
    return data;
  }
}