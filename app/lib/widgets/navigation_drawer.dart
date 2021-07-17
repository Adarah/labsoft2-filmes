import 'package:app/viewmodels/navigator_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.orange,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildDrawerOption(
                  name: 'Página inicial',
                  icon: Icon(Icons.home),
                  screen: Screen.Home,
                ),
                _buildDrawerOption(
                  name: 'Contas vinculadas',
                  icon: Icon(Icons.link),
                  screen: Screen.LinkedAccounts,
                ),
                _buildDrawerOption(
                  name: 'Avaliações',
                  icon: Icon(Icons.reviews),
                  screen: Screen.Reviews,
                ),
                _buildDrawerOption(
                  name: 'Perfil',
                  icon: Icon(Icons.account_circle),
                  screen: Screen.Profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerOption({
    name: String,
    screen: Screen,
    icon: Icon,
  }) {
    return Consumer<NavigatorViewmodel>(
      builder: (context, screenModel, child) => ElevatedButton.icon(
        onPressed: () => screenModel.selectedScreen = screen,
        icon: icon,
        label: Text(name),
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          primary: screenModel.selectedScreen == screen
              ? Colors.white
              : Colors.orange,
          onPrimary: screenModel.selectedScreen == screen
              ? Colors.orange
              : Colors.white,
        ),
      ),
    );
  }
}
