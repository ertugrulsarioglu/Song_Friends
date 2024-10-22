import '../../myPostsPage/my_posts.dart';
import '../model/user_model.dart';
import '../profile.dart';
import '../../profileUpdatePage/profil_update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/auth_manager.dart';
import '../../../../core/cache_manager.dart';
import '../../../../login/view/login_view.dart';

abstract class ProfileViewModel extends State<Profile> {
  String token = '';
  late CacheManager cacheManager = CacheManager();
  late UserModel? userModel;

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  Future<void> initializeState() async {
    // context.watch<AuthenticationManager>().model;
    context.read<AuthenticationManager>().userModel;
    userModel = context.read<AuthenticationManager>().userModel;
    await getTokenCache();
  }

  Future<void> getTokenCache() async {
    token = await cacheManager.getToken() ?? '';
    setState(() {});
  }

  void navigateToLogin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false);

    context.read<AuthenticationManager>().removeAllData();
    setState(() {});
  }

  void get navigateToProfileUpdate {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Provider.value(
              value: context.read<AuthenticationManager>().userModel,
              child: const ProfileUpdate(),
            )));
  }

  void get navigateToMyPosts {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const MyPosts(),
    ));
  }
}
