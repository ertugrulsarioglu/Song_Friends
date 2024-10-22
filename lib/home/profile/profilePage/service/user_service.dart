import 'dart:io';

import '../model/user_model.dart';
import 'IUserService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../constants/string_constants.dart';

class UserService extends IUserService with StringConstants {
  final BuildContext context;
  UserService(this.context);
  @override
  Future<UserModel?> postUserAuth(String token) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      String bearerToken = 'Bearer $token';
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: bearerToken});
      final response = await dio.get(userPath, options: options);
      if (response.statusCode == HttpStatus.ok) {
        final loadModel = UserModel.fromJson(response.data);
        return loadModel;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null &&
          e.response?.statusCode == HttpStatus.unauthorized) {
        // print('yetkilendirme hatasi: ${e.response!.data}');
        showModalBottomSheet(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: Text(
                    textAlign: TextAlign.center,
                    'yetkilendirme hatasi: ${e.response!.data}')),
          ),
        );

        // ignore: use_build_context_synchronously
        FocusScope.of(context).unfocus();

        return Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(context);
          return null;
        });
      } else {
        if (kDebugMode) {
          print('Hata olustu: $e');
        }
      }
      return null;
    }
  }
}
