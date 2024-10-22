import 'dart:io';

import 'package:Mevo/constants/string_constants.dart';
import 'package:Mevo/core/auth_manager.dart';
import 'package:Mevo/home/profile/myPostsPage/model/my_posts_model.dart';
import 'package:Mevo/home/profile/myPostsPage/service/IMyPostsService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPostsService extends IMyPostsService with StringConstants {
  final BuildContext context;

  MyPostsService(this.context);
  @override
  Future<MyPostsModel?> postGetMyPosts(String token) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      final String userId =
          context.read<AuthenticationManager>().userModel!.id.toString();

      String bearerToken = 'Bearer $token';
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: bearerToken});

      final response = await dio.get('${IMyPostsServicePath.All.name}$userId?',
          options: options, queryParameters: {'pageSize': 10, 'page': 1});
      await Future.delayed(
          const Duration(seconds: 1)); //shimmeri hallettikten sonra bunu kaldir
      if (response.statusCode == HttpStatus.ok) {
        final loadModel = MyPostsModel.fromJson(response.data);
        return loadModel;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null &&
              e.response?.statusCode == HttpStatus.badGateway ||
          e.response?.statusCode == HttpStatus.unauthorized) {
        showModalBottomSheet(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: Text(
                    textAlign: TextAlign.center,
                    'Hatalı Ağ Geçidi veya Yetkilendirme Hatası: ${e.response!.data}')),
          ),
        );

        // ignore: use_build_context_synchronously
        FocusScope.of(context).unfocus();
      }
      print(e);
    }
    throw UnimplementedError();
  }
}
