import 'package:Mevo/constants/navigator_constants.dart';
import 'package:Mevo/home/discover/service/discover_service.dart';

// import 'package:Mevo/home/profile.dart';
import 'package:Mevo/home/profile/profilePage/service/user_service.dart';

import '../../core/auth_manager.dart';
import '../../home/profile/profilePage/viewmodel/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late UserService userService = UserService(context);
  late DiscoverService discoverService = DiscoverService(context);

  Future<void> controlToApp() async {
    await readAuthManager.fetchUserData();

    if (readAuthManager.isLogin) {
      readAuthManager.userModel =
          await userService.postUserAuth(readAuthManager.token ?? '');

      readAuthManager.discoverModel =
          await discoverService.postPostAuth(readAuthManager.token ?? '');

      readAuthManager.userModel;
      readAuthManager.discoverModel;

      // ignore: use_build_context_synchronously
      context.read<ProfileCubit>().updateUser(readAuthManager
              .userModel?.username ??
          ''); // TODO: ilk acildiginda profil bos olmamasi icin kullandik !!

      // ignore: use_build_context_synchronously
      NavigatorConstants.navigateToManagement(context);
    } else {
      // ignore: use_build_context_synchronously
      NavigatorConstants.navigateToLogin(context);
    }
  }

  AuthenticationManager get readAuthManager =>
      context.read<AuthenticationManager>();

  @override
  void initState() {
    super.initState();
    controlToApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
