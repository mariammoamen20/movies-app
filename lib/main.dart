import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc_observer.dart';
import 'package:movie_app/layout/cubit/cubit.dart';
import 'package:movie_app/modules/movie_details/cubit/cubit.dart';
import 'package:movie_app/modules/splash/splash_screen.dart';
import 'package:movie_app/shared/network/remote/dio_helper.dart';
import 'package:movie_app/shared/styles/theme.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const SplashScreen(),
    );
  }
}
