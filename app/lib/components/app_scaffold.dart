import 'package:app/components/navigation_drawer.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      drawer: NavigationDrawer(),
      body: Placeholder(),
    );
  }
}
