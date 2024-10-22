import 'package:Mevo/constants/padding_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/string_constants.dart';
import '../../login/view/login_view.dart';
import '../service/register_service.dart';
import '../viewmodel/register_cubit.dart';
import '../source/register_view_source.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with RegisterViewSource, PaddingConstants, StringConstants {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(
              registerFormKey,
              usernameController,
              emailController,
              passwordController,
              service: RegisterService(Dio(BaseOptions(baseUrl: baseUrl))),
            ),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterComplete) {
              buildshowModalBottomSheetRegisterComplete(context)
                  .then((value) => state.navigate(context));
              // state.navigate(context);
            } else if (state is RegisterFail) {
              buildShowModalBottomSheetRegisterFail(context, state)
                  .then((value) {
                allContorllerEmpty;
              });
            }
          },
          builder: (context, state) {
            return buildScaffold(context, state);
          },
        ));
  }

  Future<dynamic> buildshowModalBottomSheetRegisterComplete(
      BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        width: bottomSheetWidth(context),
        height: bottomSheetHeight(context),
        child: Center(
            child: Text(textAlign: TextAlign.center, registerCompleteText)),
      ),
    );

    FocusScope.of(context).unfocus();

    return Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(context);
    });
  }

  Future<dynamic> buildShowModalBottomSheetRegisterFail(
      BuildContext context, RegisterFail state) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        width: bottomSheetWidth(context),
        height: bottomSheetHeight(context),
        child: Center(
            child: Text(textAlign: TextAlign.center, '${state.model.message}')),
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, RegisterState state) {
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
              visible: context.read<RegisterCubit>().isLoading,
              child: const CircularProgressIndicator()),
        )
      ],
      title: Text(registerText),
      centerTitle: true,
    );
  }

  Form buildBodyForm(RegisterState state, BuildContext context) {
    return Form(
      autovalidateMode: state is RegisterValidateState
          ? (state.isRegisterValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled)
          : AutovalidateMode.disabled,
      key: registerFormKey,
      child: Padding(
        padding: buildDefaultSymetricPadding(context),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            children: [
              buildTextFormFieldUsername(),
              buildTextFormFieldEmail(),
              buildTextFormFieldPassword(),
              buildTextButtonRegister(context)
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldUsername() {
    return TextFormField(
      controller: usernameController,
      validator: (value) {
        if ((value ?? '').isEmpty) {
          return userNameIsEmptyText;
        }

        if ((value ?? '').length <= 4) {
          return userNameValidateText;
        }
        return null;
      },
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: userNameText),
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
      obscureText: !isPasswordVisible,
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
          labelText: passwordText,
          suffixIcon: IconButton(
            icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          )),
    );
  }

  TextButton buildTextButtonRegister(BuildContext context) {
    return TextButton(
        onPressed: context.read<RegisterCubit>().isLoading
            ? null
            : () {
                context.read<RegisterCubit>().postUserRegisterModel();
                FocusScope.of(context).unfocus();
              },
        child: Text(registerText));
  }
}

extension RegisterCompleteExtension on RegisterComplete {
  void navigate(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
        (route) => false);
  }
}
