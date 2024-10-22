// ignore_for_file: file_names, constant_identifier_names

import 'package:Mevo/home/profile/profilePage/model/user_model.dart';
import 'package:dio/dio.dart';

abstract class IUserService {
  late Dio dio;

  final String userPath = IUserServicePath.ME.rawValue;

  Future<UserModel?> postUserAuth(String token);
}

enum IUserServicePath { ME }

extension IUsersServicePathExtension on IUserServicePath {
  String get rawValue {
    switch (this) {
      case IUserServicePath.ME:
        return '/users/me';
    }
  }
}
