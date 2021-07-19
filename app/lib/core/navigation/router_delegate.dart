import 'package:app/core/navigation/pages/linked_accounts_page.dart';
import 'package:app/core/navigation/pages/movie_details_page.dart';
import 'package:app/viewmodels/auth_viewmodel.dart';
import 'package:app/viewmodels/navigator_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/review_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/splash_page.dart';

class MovieRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<Page> _pages = [];

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewmodel, NavigatorViewmodel>(
      builder: (context, auth, nav, child) {
        final selection = nav.selectedScreen;
        final authState = auth.authState;

        if (authState == AuthState.unknown) {
          _pages = [SplashPage()];
        } else if (authState == AuthState.loggedIn) {
          _pages = [
            if (selection == Screen.Home) HomePage(),
            if (selection == Screen.Reviews) ReviewPage(),
            if (nav.selectedMovie != null)
              MovieDetailsPage(movie: nav.selectedMovie!),
            if (selection == Screen.LinkedAccounts) LinkedAccountsPage(),
            if (selection == Screen.Profile) ProfilePage(),
          ];
        } else {
          _pages = [SignInPage()];
        }
        return Navigator(
          key: navigatorKey,
          pages: _pages,
          onPopPage: _onPopPage,
        );
      },
    );
  }

  bool _onPopPage(Route route, dynamic result) {
    if (!route.didPop(result)) {
      return false;
    }
    popRoute();
    return true;
  }

  @override
  Future<bool> popRoute() async {
    print(_pages);
    if (_pages.length > 1) {
      _pages.removeLast();
      notifyListeners();
      print('popping len > 1');
      return Future.value(true);
    }
    print('popping');
    final exit = await _confirmAppExit();
    print(exit);
    return exit ?? true;
    // if (_pages.length == 1) {
    //   // Null means they clicked outside of the dialog box
    //   // Which indicates their intent to cancel exiting the app
    //   return await _confirmAppExit() ?? true;
    // }
    // _pages.removeLast();
    // notifyListeners();
    // return Future.value(true);
  }

  Future<bool?> _confirmAppExit() {
    print(navigatorKey.currentContext);
    return showDialog<bool>(
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(dynamic configuration) async {}
}
