import 'package:flutter/material.dart';

mixin RegisterViewSource {
  final GlobalKey<FormState> registerFormKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void get allContorllerEmpty {
    usernameController.text = '';
    emailController.text = '';
    passwordController.text = '';
  }
}
