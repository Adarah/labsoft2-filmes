import 'package:app/core/auth/auth_service.dart';
import 'package:app/core/navigation/router_delegate.dart';
import 'package:app/models/movie_repository.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:app/viewmodels/linked_accounts_viewmodel.dart';
import 'package:app/viewmodels/navigator_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late final MovieRouterDelegate delegate;

  @override
  void initState() {
    super.initState();
    delegate = MovieRouterDelegate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewmodel>(
          create: (_) => AuthViewmodel(FirebaseAuthService()),
        ),
        ChangeNotifierProvider<NavigatorViewmodel>(
          create: (_) => NavigatorViewmodel(),
        ),
        ChangeNotifierProvider<LinkedAccountsViewmodel>(
          create: (_) => LinkedAccountsViewmodel(),
        ),
        Provider<MovieRepository>(
          create: (_) => MovieRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Filmes App',
        theme: _filmesAppTheme(),
        home: Router(
          routerDelegate: MovieRouterDelegate(),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }

  ThemeData _filmesAppTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }
      ),
      colorScheme: base.colorScheme.copyWith(
        primary: Colors.orange[800],
        secondary: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
