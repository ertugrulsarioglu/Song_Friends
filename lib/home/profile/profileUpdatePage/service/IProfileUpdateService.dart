import 'package:Mevo/home/profile/profileUpdatePage/model/profile_update_req_model.dart';

abstract class IProfileUpdateService {
  Future<bool> patchUser(ProfileUpdateReqModel updateReqModel, String id);
}

enum IProfileServicePath {
  ID('/users/');

  final String name;
  const IProfileServicePath(this.name);
}
