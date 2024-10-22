import 'package:flutter/material.dart';
import '../home/management.dart';
import '../login/view/login_view.dart';
import '../register/view/register_view.dart';
import '../splash/view/splash_view.dart';

class NavigatorConstants {
  static Future<dynamic> navigateToSplashForControltoApp(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashView(),
        ),
        (route) => false);
  }

  static void navigateToManagement(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Management(),
    ));
  }

  static void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginView(),
    ));
  }

  static void navigateToRegister(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const RegisterView(),
    ));
  }
}
