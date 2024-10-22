class MyPostsModel {
  List<Posts>? posts;
  int? totalCount;

  MyPostsModel({this.posts, this.totalCount});

  MyPostsModel.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class Posts {
  String? id;
  String? createdAt;
  String? userId;
  String? mediaId;
  String? content;
  String? title;
  String? updatedAt;
  User? user;
  int? totalLikes;
  int? totalComments;
  String? mediaUrl;
  bool? isLiked;

  Posts(
      {this.id,
      this.createdAt,
      this.userId,
      this.mediaId,
      this.content,
      this.title,
      this.updatedAt,
      this.user,
      this.totalLikes,
      this.totalComments,
      this.mediaUrl,
      this.isLiked});

  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    mediaId = json['media_id'];
    content = json['content'];
    title = json['title'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    totalLikes = json['totalLikes'];
    totalComments = json['totalComments'];
    mediaUrl = json['media_url'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['media_id'] = mediaId;
    data['content'] = content;
    data['title'] = title;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['totalLikes'] = totalLikes;
    data['totalComments'] = totalComments;
    data['media_url'] = mediaUrl;
    data['is_liked'] = isLiked;
    return data;
  }
}

class User {
  Avatar? avatar;
  String? email;
  String? username;
  String? gender;
  bool? isEmailVerified;

  User(
      {this.avatar,
      this.email,
      this.username,
      this.gender,
      this.isEmailVerified});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
    email = json['email'];
    username = json['username'];
    gender = json['gender'];
    isEmailVerified = json['is_email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    data['email'] = email;
    data['username'] = username;
    data['gender'] = gender;
    data['is_email_verified'] = isEmailVerified;
    return data;
  }
}

class Avatar {
  String? mediaUrl;

  Avatar({this.mediaUrl});

  Avatar.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['media_url'] = mediaUrl;
    return data;
  }
}
