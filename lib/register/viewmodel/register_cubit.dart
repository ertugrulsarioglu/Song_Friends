import 'package:bloc/bloc.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../service/register_service.dart';
import 'package:flutter/material.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final GlobalKey<FormState> registerFormKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final RegisterService service;

  bool isRegisterFail = false;
  bool isLoading = false;

  RegisterCubit(this.registerFormKey, this.usernameController,
      this.emailController, this.passwordController,
      {required this.service})
      : super(RegisterInitial());
  Future<void> postUserRegisterModel() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      changeRegisterLoadingView();
      final data = await service.postUserRegister(RegisterRequestModel(
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        isActive: true,
      ));
      if (data is RegisterResponseModel) {
        if (data.accessToken != null) {
          emit(RegisterComplete(data));
        } else {
          emit(RegisterFail(data));
        }
      }
      changeRegisterLoadingView();
    } else {
      isRegisterFail = true;
      RegisterValidateState(isRegisterFail);
    }
  }

  void changeRegisterLoadingView() {
    isLoading = !isLoading;
    emit(RegisterLoadingView(isLoading));
  }
}

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterComplete extends RegisterState {
  final RegisterResponseModel model;

  RegisterComplete(this.model);
}

class RegisterFail extends RegisterState {
  final RegisterResponseModel model;

  RegisterFail(this.model);
}

class RegisterValidateState extends RegisterState {
  final bool isRegisterValidate;

  RegisterValidateState(this.isRegisterValidate);
}

class RegisterLoadingView extends RegisterState {
  final bool isRegisterLoading;

  RegisterLoadingView(this.isRegisterLoading);
}
