class ProfileUpdateReqModel {
  String? username;
  int? age;

  ProfileUpdateReqModel({this.username, this.age});

  ProfileUpdateReqModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['age'] = age;
    return data;
  }
}
