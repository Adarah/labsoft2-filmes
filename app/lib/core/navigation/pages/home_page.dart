import 'package:app/core/home/home_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends Page {
  const HomePage({Key? key}) : super(key: const ValueKey('HomePage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => HomeScreen(),
    );
  }
}
