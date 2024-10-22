import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../core/auth_manager.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../service/login_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final LoginService service;

  final AuthenticationManager authManager;

  bool isLoginFail = false;
  bool isLoading = false;

  LoginCubit(this.formKey, this.emailController, this.passwordController,
      this.authManager,
      {required this.service})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formKey.currentState?.validate() ?? false) {
      changeLoadingView();
      final data = await service
          .postUserLogin(LoginRequestModel(email: email, password: password));
      if (data is LoginResponseModel) {
        if (data.accessToken != null) {
          authManager.setToken(data.accessToken ?? '');
          authManager
              .fetchUserData()
              .then((value) => emit(LoginComplete(data)));
        } else {
          emit(LoginFail(data));
          const SnackBar(content: Text('Sunucu Hatasi'));
        }
      }
      changeLoadingView();
    } else {
      isLoginFail = true;
      LoginValidateState(isLoginFail);
    }
  }

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  void changeLoadingView() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginComplete extends LoginState {
  final LoginResponseModel model;

  LoginComplete(this.model);
}

class LoginFail extends LoginState {
  final LoginResponseModel model;

  LoginFail(this.model);
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}
