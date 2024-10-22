// ignore: file_names
import 'package:dio/dio.dart';

// ignore: file_names
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';

abstract class ILoginServixce {
  final Dio dio;

  ILoginServixce(this.dio);

  final String loginPath = ILoginServicePath.LOGIN.rawValue;

  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model);
}

// ignore: constant_identifier_names
enum ILoginServicePath { LOGIN }

extension ILoginServicePathExtension on ILoginServicePath {
  String get rawValue {
    switch (this) {
      case ILoginServicePath.LOGIN:
        return '/auth/login';
    }
  }
}
