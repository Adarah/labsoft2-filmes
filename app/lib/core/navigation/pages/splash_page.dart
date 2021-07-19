import 'package:app/core/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends Page {
  const SplashPage({Key? key}) : super(key: const ValueKey('SplashPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => SplashScreen(),
    );
  }
}
