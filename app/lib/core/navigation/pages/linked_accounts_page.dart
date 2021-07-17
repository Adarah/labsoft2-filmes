import 'package:app/core/linked_accounts/linked_accounts_screen.dart';
import 'package:flutter/material.dart';

class LinkedAccountsPage extends Page {
  const LinkedAccountsPage({Key? key}) : super(key: const ValueKey('LinkedAccountsPage'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => LinkedAccountsScreen(),
    );
  }
}
