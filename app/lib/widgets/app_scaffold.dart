import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'navigation_drawer.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  const AppScaffold({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewmodel = Provider.of<AuthViewmodel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            onPressed: authViewmodel.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: body,
    );
  }
}
