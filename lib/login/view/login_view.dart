import 'package:Mevo/constants/navigator_constants.dart';
import '../../constants/padding_constants.dart';
import '../../home/profile/profilePage/profile.dart';
import '../../constants/string_constants.dart';
import '../../core/auth_manager.dart';
import '../service/login_service.dart';
import '../viewmodel/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with PaddingConstants, StringConstants {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  final AuthenticationManager authManager = AuthenticationManager();

  void get allControllerEmpty {
    emailController.text = "";
    passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formKey,
        emailController,
        passwordController,
        authManager,
        service: LoginService(Dio(BaseOptions(baseUrl: baseUrl))),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginComplete) {
            state.navigateToHome(context);
            NavigatorConstants.navigateToSplashForControltoApp(context);
            allControllerEmpty;
          } else if (state is LoginFail) {
            buildLoginFailShowDialog(context, state);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Future<dynamic> buildLoginFailShowDialog(
      BuildContext context, LoginFail state) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(alertText),
        contentPadding: loginFailDialogContentPadding,
        content: Text(state.model.message ?? ''),
        actions: [
          TextButton(
              onPressed: () {
                allControllerEmpty;
                Navigator.of(context).pop();
              },
              child: Text(loginFailShowDialogText))
        ],
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBodyForm(state, context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: appBarActinonsPadding(context),
          child: Visibility(
              visible: context.watch<LoginCubit>().isLoading,
              child: const CircularProgressIndicator()),
        ),
      ],
      title: Text(loginViewAppBarTitleText),
      centerTitle: true,
    );
  }

  Form buildBodyForm(LoginState state, BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: state is LoginValidateState
          ? (state.isValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled)
          : AutovalidateMode.disabled,
      child: Padding(
        padding: buildDefaultSymetricPadding(context),
        child: Center(
          child: Wrap(
            runSpacing: spacingLow(context),
            alignment: WrapAlignment.center,
            children: [
              buildTextFormFieldEmail(),
              buildTextFormFieldPassword(),
              Column(
                children: [
                  buildElevatedButtonLogin(context),
                  buildTextButtonRegister(context)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return emailIsEmptyText;
        }
        // Regular expression for email validation
        String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        RegExp regex = RegExp(emailPattern);
        if (!regex.hasMatch(value!)) {
          return emailValidateText;
        }
        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: emailText),
    );
  }

  TextFormField buildTextFormFieldPassword() {
    return TextFormField(
      obscureText: !_isPasswordVisible,
      controller: passwordController,
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return textFormFieldPasswordIsEmptyText;
        } else if ((value ?? '').length < 5) {
          return textFormFieldPasswordValidateText;
        }

        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: passwordTextFormFieldLabelText,
          suffixIcon: IconButton(
            icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )),
    );
  }

  Widget buildElevatedButtonLogin(BuildContext context) {
    return ElevatedButton(
        onPressed: context.watch<LoginCubit>().isLoading
            ? null
            : () {
                context.read<LoginCubit>().postUserModel();
                FocusScope.of(context).unfocus();
              },
        child: Text(loginButtonText));
  }

  TextButton buildTextButtonRegister(BuildContext context) {
    return TextButton(
        onPressed: context.watch<LoginCubit>().isLoading
            ? null
            : () {
                LoginLoadingState(false);
                NavigatorConstants.navigateToRegister(context);
              },
        child: Text(
          registerText,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.022,
              fontWeight: FontWeight.normal),
        ));
  }
}

extension LoginCompleteExtension on LoginComplete {
  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Profile(),
    ));
  }
}
