import 'package:flutter/material.dart';
import 'package:movie_app/layout/layout_screen.dart';
import 'package:movie_app/shared/components/components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLayout();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Image(
        image: AssetImage('assets/images/splash.png',),
        fit: BoxFit.cover,
      ),
    );
  }
  navigateToLayout()async{
   await Future.delayed(const Duration(milliseconds: 3000,),(){});
   navigateToAndFinish(context, const LayoutScreen());
  }
}
