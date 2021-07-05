import 'package:app/modules/auth/auth_service.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/loading_page.dart';
import 'components/something_went_wrong_page.dart';
import 'landing_page.dart';
import 'modules/auth/sign_in_page.dart';
import 'modules/auth/sign_up_page.dart';
import 'modules/reviews/reviews_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes App',
      theme: _filmesAppTheme(),
      home: LandingPage(),
      routes: {
        '/signIn': (context) => SignInPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/reviews': (context) => ReviewsPage(),
      },
    );
  }

  ThemeData _filmesAppTheme() {
    final base = ThemeData.light();
    return base.copyWith(
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
      //
      // )
    );
  }
}
