import 'package:Mevo/core/auth_manager.dart';
import 'package:Mevo/core/cache_manager.dart';
import 'package:Mevo/home/profile/myPostsPage/model/my_posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_posts.dart';
import '../service/my_posts_service.dart';

abstract class MyPostsViewModel extends State<MyPosts> {
  String token = '';
  late CacheManager cacheManager = CacheManager();
  MyPostsModel? myPostsModel;
  late MyPostsService myPostsService = MyPostsService(context);
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    initializeState;
  }

  Future<void> get initializeState async {
    // context.read<AuthenticationManager>().myPostsModel;

    await getTokenCache();
    await loadedPostsModel();
  }

  Future<void> loadedPostsModel() async {
    readAuthManager.myPostsModel =
        await myPostsService.postGetMyPosts(readAuthManager.token ?? '');
    myPostsModel = readAuthManager.myPostsModel;
    setState(() {});
    isLoad = true;
  }

  Future<void> getTokenCache() async {
    token = await cacheManager.getToken() ?? '';
    setState(() {});
  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();
}
