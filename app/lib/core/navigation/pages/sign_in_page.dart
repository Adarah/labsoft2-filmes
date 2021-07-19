import 'package:app/core/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SignInPage extends Page {
  const SignInPage({Key? key}) : super(key: const ValueKey('SignInPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => SignInScreen(),
    );
  }
}
