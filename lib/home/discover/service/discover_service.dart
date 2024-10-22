import 'dart:io';

import 'package:Mevo/constants/string_constants.dart';
import 'package:Mevo/core/auth_manager.dart';
import 'package:Mevo/core/cache_manager.dart';
import 'package:Mevo/home/discover/model/discover_model.dart';
import 'package:Mevo/home/discover/service/IDiscoverService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoverService extends IDiscoverService with StringConstants {
  final BuildContext context;

  DiscoverService(this.context);
  @override
  Future<DiscoverModel?> postPostAuth(String token) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));

      String bearerToken = 'Bearer $token';
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: bearerToken});

      final response = await dio.get(IDiscoverServicePath.ALL.name,
          options: options, queryParameters: {'pageSize': 10, 'page': 1});

      if (response.statusCode == HttpStatus.ok) {
        final loadModel = DiscoverModel.fromJson(response.data);
        return loadModel;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null &&
          e.response?.statusCode == HttpStatus.badGateway) {
        showModalBottomSheet(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
                child: Text(
                    textAlign: TextAlign.center,
                    'Hatalı Ağ Geçidi: ${e.response!.data}')),
          ),
        );

        // ignore: use_build_context_synchronously
        FocusScope.of(context).unfocus();
      }
      print(e);
    }

    throw UnimplementedError();
  }

  @override
  Future<bool?> postLikePosts(String postId) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      String bearerToken = 'Bearer ${await CacheManager().getToken() ?? ''}';
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: bearerToken});

      final response = await dio.post(
          '${IDiscoverServicePath.POSTS.name}$postId${IDiscoverServicePath.LIKES.name}${context.read<AuthenticationManager>().userModel?.id.toString()}',
          options: options);
      return response.statusCode == 201;
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<bool?> deleteLike(String postId) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      String bearerToken = 'Bearer ${await CacheManager().getToken() ?? ''}';
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: bearerToken});

      final response = await dio.delete(
          '${IDiscoverServicePath.POSTS.name}$postId${IDiscoverServicePath.LIKES.name}${context.read<AuthenticationManager>().userModel?.id.toString()}',
          options: options);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
