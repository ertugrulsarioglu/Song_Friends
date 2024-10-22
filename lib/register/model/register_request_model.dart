class RegisterRequestModel {
  String? username;
  String? email;
  String? password;
  bool isActive = true;

  RegisterRequestModel(
      {this.username, this.email, this.password, required this.isActive});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['is_active'] = isActive;
    return data;
  }
}
