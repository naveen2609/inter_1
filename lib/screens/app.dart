import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inter_1/logic/bloc/auth_bloc/auth_bloc.dart';
import 'package:inter_1/logic/bloc/post_bloc/post_bloc.dart';
import 'package:inter_1/logic/controller/auth_controller.dart';
import 'package:inter_1/logic/controller/post_controller.dart';
import 'package:inter_1/screens/auth/login_screen.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthController()),
        RepositoryProvider(create: (_) => PostController()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthController>(context),
            ),
          ),

           BlocProvider(
            create: (context) => PostBloc(
              postRepository: RepositoryProvider.of<PostController>(context),
            ),
          ),
        ],
        child: const MaterialApp(
          title: 'Social App',
          home: SplashScreen(),
        ),
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to Social App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}