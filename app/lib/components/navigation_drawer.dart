import 'package:flutter/material.dart';

class MenuOption {
  final String displayName; //: 'Página inicial',
  final Widget icon; // ': Icons.home,
  final String route;
  bool isActive;

  MenuOption(this.displayName, this.icon, this.route, this.isActive);
}

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  int _selectedIndex = 0;
  final menuOptions = [
    MenuOption('Página inicial', Icon(Icons.home), '/', false),
    MenuOption('Contas vinculadas', Icon(Icons.link), '/linked_accounts', false),
    MenuOption('Avaliações', Icon(Icons.reviews), '/reviews', false),
    MenuOption('Perfil', Icon(Icons.account_circle), '/profile', false),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      print(ModalRoute.of(context)!.settings.name);
      menuOptions.forEach((option) {
        if (ModalRoute.of(context)!.settings.name == option.route) {
          option.isActive = true;
        } else {
          option.isActive = false;
        }
      });
    });
    return Drawer(
      child: Container(
        color: Colors.orange,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: menuOptions.map((option) {
                  return ElevatedButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(context, option.route),
                    icon: option.icon,
                    label: Text(option.displayName),
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      primary: option.isActive
                          ? Colors.white
                          : Colors.orange,
                      onPrimary: option.isActive
                          ? Colors.orange
                          : Colors.white,
                    ),
                  );
                }).toList(),
              )),
        ),
      ),
    );
  }
}
