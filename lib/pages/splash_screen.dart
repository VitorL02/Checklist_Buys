import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:checklist_buys/pages/checkList.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const CheckListPage(),
      splash:'lib/assets/car_splashArt.png',
      //TODO adicionar a imagem do carrinho e a cor da pagina principal que sera preta
      //TODO adicionar uma cor de transição (provavelmente Rosa)
    );
  }
}