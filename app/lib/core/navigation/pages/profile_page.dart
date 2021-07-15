import 'package:app/core/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends Page {
  const ProfilePage({Key? key}) : super(key: const ValueKey('ProfilePage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => ProfileScreen(),
    );
  }
}
