import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import 'IRegisterService.dart';

class RegisterService extends IRegisterService {
  RegisterService(super.dio);

  @override
  Future<RegisterResponseModel?> postUserRegister(
      RegisterRequestModel model) async {
    try {
      final response = await dio.post(registerPath, data: model.toJson());

      if (response.statusCode == HttpStatus.created) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null &&
          e.response?.statusCode == HttpStatus.badRequest) {
        return RegisterResponseModel.fromJson(e.response?.data);
      } else {
        if (kDebugMode) {
          print("Network error: $e");
        }
        // Genel bir ağ hatası mesajı göster
      }
    }
    return null;
  }
}
