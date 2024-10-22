import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import 'ILoginService.dart';

class LoginService extends ILoginServixce {
  LoginService(super.dio);

  @override
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model) async {
    try {
      final response = await dio.post(loginPath, data: model.toJson());

      if (response.statusCode == HttpStatus.created) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == HttpStatus.notFound) {
        return LoginResponseModel.fromJson(e.response?.data);
      } else if (e.response?.statusCode == HttpStatus.badGateway) {
        print('Sunucu coktu');
      }
      {
        if (kDebugMode) {
          print('Network Error: $e');
        }
        //Genel bir ağ hatası mesajı göster
      }
    }
    return null;
  }
}
