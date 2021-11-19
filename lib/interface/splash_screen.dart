import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app_api/utils/page_router.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.blue,
      splash: Image.asset(
        'assets/splash_icon.png',
      ),
      nextScreen: const PageRouter(),
    );
  }
}
