class RegisterResponseModel {
  int? statusCode;
  String? message;
  String? error;
  String? accessToken;

  RegisterResponseModel(
      {this.statusCode, this.message, this.error, this.accessToken});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['error'] = error;
    data['access_token'] = accessToken;
    return data;
  }
}
