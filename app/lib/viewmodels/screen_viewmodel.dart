import 'package:flutter/foundation.dart';

enum Screen {
  Home,
  Reviews,
  Profile,
  LinkedAccounts,
}

class ScreenViewmodel with ChangeNotifier {
  Screen _selectedScreen = Screen.Home;

  Screen get selectedScreen => _selectedScreen;

  set selectedScreen(Screen value) {
    _selectedScreen = value;
    notifyListeners();
  }

  ScreenViewmodel();
}
