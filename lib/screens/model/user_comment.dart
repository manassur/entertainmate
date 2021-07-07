class UserCommentModel {
  bool error;
  bool isOwnPost;
  List<Comments> comments;

  UserCommentModel({this.error, this.isOwnPost, this.comments});

  UserCommentModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    isOwnPost = json['isOwnPost'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['isOwnPost'] = this.isOwnPost;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String id;
  String postId;
  String username;
  String name;
  String icon;
  String content;
  String creation;
  String repliesCount;
  List<Replies> replies;

  Comments(
      {this.id,
        this.postId,
        this.username,
        this.name,
        this.icon,
        this.content,
        this.creation,
        this.repliesCount,
        this.replies});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    username = json['username'];
    name = json['name'];
    icon = json['icon'];
    content = json['content'];
    creation = json['creation'];
    repliesCount = json['repliesCount'];
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postId;
    data['username'] = this.username;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['content'] = this.content;
    data['creation'] = this.creation;
    data['repliesCount'] = this.repliesCount;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  String id;
  String commentId;
  String userId;
  String username;
  String isVerified;
  String name;
  String icon;
  String content;
  String creation;

  Replies(
      {this.id,
        this.commentId,
        this.userId,
        this.username,
        this.isVerified,
        this.name,
        this.icon,
        this.content,
        this.creation});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['comment_id'];
    userId = json['userId'];
    username = json['username'];
    isVerified = json['isVerified'];
    name = json['name'];
    icon = json['icon'];
    content = json['content'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment_id'] = this.commentId;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['isVerified'] = this.isVerified;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['content'] = this.content;
    data['creation'] = this.creation;
    return data;
  }
}