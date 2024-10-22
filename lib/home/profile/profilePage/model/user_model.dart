class UserModel {
  String? id;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? username;
  String? email;
  int? age;
  int? credit;
  String? avatarId;
  String? countryCode;
  String? gender;
  String? password;
  bool? isEmailVerified;
  String? lastActivityTime;
  String? firebaseToken;
  String? profilePhotoUrl;
  int? statusCode;
  String? message;

  UserModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.username,
      this.email,
      this.age,
      this.credit,
      this.avatarId,
      this.countryCode,
      this.gender,
      this.password,
      this.isEmailVerified,
      this.lastActivityTime,
      this.firebaseToken,
      this.profilePhotoUrl,
      this.statusCode,
      this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    username = json['username'];
    email = json['email'];
    age = json['age'];
    credit = json['credit'];
    avatarId = json['avatar_id'];
    countryCode = json['country_code'];
    gender = json['gender'];
    password = json['password'];
    isEmailVerified = json['is_email_verified'];
    lastActivityTime = json['last_activity_time'];
    firebaseToken = json['firebase_token'];
    profilePhotoUrl = json['profile_photo_url'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['username'] = username;
    data['email'] = email;
    data['age'] = age;
    data['credit'] = credit;
    data['avatar_id'] = avatarId;
    data['country_code'] = countryCode;
    data['gender'] = gender;
    data['password'] = password;
    data['is_email_verified'] = isEmailVerified;
    data['last_activity_time'] = lastActivityTime;
    data['firebase_token'] = firebaseToken;
    data['profile_photo_url'] = profilePhotoUrl;
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }
}
