// ignore_for_file: empty_statements

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:checklist_buys/pages/checkList.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ;
    return AnimatedSplashScreen(
      nextScreen: const CheckListPage(),
      splash: 'lib/assets/car_splashArt.png',
      backgroundColor: Colors.black,
      duration: 2000,
      centered: true,
      splashTransition: SplashTransition.slideTransition,
      //TODO adicionar uma cor de transição (provavelmente Rosa)
    );
  }
}
