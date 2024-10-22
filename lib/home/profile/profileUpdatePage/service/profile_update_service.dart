import 'dart:io';

import 'package:Mevo/core/cache_manager.dart';
import 'package:Mevo/home/profile/profileUpdatePage/model/profile_update_req_model.dart';
import 'package:dio/dio.dart';

import '../../../../constants/string_constants.dart';
import 'IProfileUpdateService.dart';

class ProfileUpdateService extends IProfileUpdateService with StringConstants {
  @override
  Future<bool> patchUser(
      ProfileUpdateReqModel updateReqModel, String id) async {
    try {
      final dio = Dio(BaseOptions(baseUrl: baseUrl));
      String? token = await CacheManager().getToken();
      Options options =
          Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      final response = await dio.patch(IProfileServicePath.ID.name + id,
          data: updateReqModel.toJson(), options: options);

      if (response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
