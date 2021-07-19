import 'package:app/models/movie.dart';
import 'package:flutter/foundation.dart';

enum Screen {
  Home,
  Reviews,
  Profile,
  LinkedAccounts,
}

class NavigatorViewmodel with ChangeNotifier {
  Screen _selectedScreen = Screen.Home;

  Screen get selectedScreen => _selectedScreen;

  set selectedScreen(Screen value) {
    _selectedScreen = value;
    if (_selectedScreen != Screen.Home) {
      selectedMovie = null;
    }
    notifyListeners();
  }

  Movie? _selectedMovie;
  Movie? get selectedMovie => _selectedMovie;
  set selectedMovie(Movie? value) {
    _selectedMovie = value;
    notifyListeners();
  }

  NavigatorViewmodel();
}
