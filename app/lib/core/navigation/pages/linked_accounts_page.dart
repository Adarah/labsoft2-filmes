import 'package:flutter/material.dart';

class LinkedAccountsPage extends Page {
  const LinkedAccountsPage({Key? key}) : super(key: const ValueKey('LinkedAccountsPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => Placeholder(),
    );
  }
}
