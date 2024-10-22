import 'package:Mevo/core/auth_manager.dart';
import 'package:Mevo/core/cache_manager.dart';
import 'package:Mevo/home/discover/discover.dart';
// import 'package:Mevo/home/discover/service/discover_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/discover_model.dart';

abstract class DiscoverViewModel extends State<Discover> {
  String token = '';
  late CacheManager cacheManager = CacheManager();
  late DiscoverModel? discoverModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeState();
  }

  Future<void> initializeState() async {
    context.read<AuthenticationManager>().discoverModel;

    discoverModel = context.read<AuthenticationManager>().discoverModel;

    await getTokenCache;
  }

  Future<void> get getTokenCache async {
    token = await cacheManager.getToken() ?? '';
    setState(() {});
  }
}
