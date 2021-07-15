import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'navigation_drawer.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewmodel = Provider.of<AuthViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
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
      body: Placeholder(),
    );
  }
}
