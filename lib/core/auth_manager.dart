import 'package:Mevo/home/profile/myPostsPage/model/my_posts_model.dart';

import '../home/discover/model/discover_model.dart';
import '../home/profile/profilePage/model/user_model.dart';

import 'cache_manager.dart';

class AuthenticationManager extends CacheManager {
  AuthenticationManager() {
    fetchUserData();
  }

  late String? token;

  bool isLogin = false;
  UserModel? userModel;
  DiscoverModel? discoverModel;
  MyPostsModel? myPostsModel;

  Future<void> removeAllData() async {
    isLogin = false;
    userModel = null;
    deleteToken();
  }

  Future<void> fetchUserData() async {
    token = await getToken();

    if (token != null) {
      isLogin = true;
    }
  }
}
