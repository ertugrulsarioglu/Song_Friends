// ignore_for_file: file_names, constant_identifier_names

import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import 'package:dio/dio.dart';

abstract class IRegisterService {
  final Dio dio;

  IRegisterService(this.dio);

  final String registerPath = IRegisterServicePath.REGISTER.rawValue;

  Future<RegisterResponseModel?> postUserRegister(RegisterRequestModel model);
}

enum IRegisterServicePath { REGISTER }

extension IRegisterServicePathExtension on IRegisterServicePath {
  String get rawValue {
    switch (this) {
      case IRegisterServicePath.REGISTER:
        return '/auth/register';
    }
  }
}
