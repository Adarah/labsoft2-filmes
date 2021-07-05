import 'package:app/modules/auth/auth_service.dart';
import 'package:app/modules/auth/sign_in_page.dart';
import 'package:app/modules/home/home_page.dart';
import 'package:app/modules/reviews/reviews_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/loading_page.dart';
import 'components/something_went_wrong_page.dart';
import 'modules/auth/auth_service.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);


  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SomethingWentWrongPage();
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return LoadingPage();
        }

        return Provider<AuthService>(
          create: (context) => FirebaseAuthService(),
          child: Builder(
            builder: (context) {
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              return StreamBuilder<User?>(
                stream: authService.authStateChanges(),
                initialData: authService.currentUser,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return SignInPage();
                  }
                  return HomePage();
                },
              );
            },
          ),
        );
      },
    );
  }
}
