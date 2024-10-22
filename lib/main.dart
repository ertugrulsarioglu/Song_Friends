import 'package:Mevo/home/profile/profilePage/viewmodel/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'core/auth_manager.dart';
import 'splash/view/splash_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationManager>(
          create: (context) => AuthenticationManager(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileCubit(const ProfileState()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

//TODO: multiblocprovidera bak

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mevo Proje',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const SplashView(),
    );
  }
}
