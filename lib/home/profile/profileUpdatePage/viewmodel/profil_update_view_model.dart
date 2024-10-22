import '../../profilePage/model/user_model.dart';
import '../profil_update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ProfileUpdateViewModel extends State<ProfileUpdate> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  late UserModel userModel;
  late final String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userModel = context.read<UserModel>();

    userId = context.read<UserModel>().id.toString();

    userNameController = TextEditingController(text: userModel.username ?? '');

    emailController = TextEditingController(text: userModel.email ?? '');

    ageController = TextEditingController(text: userModel.age.toString());
  }
}
