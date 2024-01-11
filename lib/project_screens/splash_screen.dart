import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:postman_project/project_screens/on_boarding_screen.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          children:
          [
            Container(
                margin:const EdgeInsetsDirectional.only(top:50),
                child: const Image(image: AssetImage("images/splash.jpg"))),
            const Text("Let's Go Shopping !",style:TextStyle(fontSize:25.0,fontWeight:FontWeight.w800),),
          ],
        ),
        nextScreen: const OnBoardingScreen(),
        splashIconSize:400.0,
        duration: 3000,
        splashTransition:SplashTransition.sizeTransition,
      );
  }
}