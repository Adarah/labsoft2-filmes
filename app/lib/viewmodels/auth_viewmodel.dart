import 'package:app/core/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

enum AuthState {
  loggedIn,
  loggedOut,
  unknown,
}

class AuthViewmodel with ChangeNotifier {
  User? _user;

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  AuthState _authState = AuthState.unknown;

  AuthState get authState => _authState;

  set authState(AuthState value) {
    _authState = value;
    notifyListeners();
  }

  bool _signingIn = false;

  bool get signingIn => _signingIn;

  set signingIn(bool value) {
    _signingIn = value;
    notifyListeners();
  }

  bool _signingOut = false;

  bool get signinOut => _signingOut;

  set signinOut(bool value) {
    _signingOut = value;
    notifyListeners();
  }

  AuthService _authService;

  AuthViewmodel(AuthService authService) : _authService = authService {
    _init();
  }

  Future<void> _init() async {
    await Firebase.initializeApp();
    user = _authService.currentUser;
    if (user != null) {
      authState = AuthState.loggedIn;
    } else {
      authState = AuthState.loggedOut;
    }
  }

  Future<void> signIn(Future<User?> Function() enter) async {
    signingIn = true;
    final user = await enter();
    signingIn = false;
    if (user != null) {
      authState = AuthState.loggedIn;
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async =>
      signIn(() => _authService.signInWithEmailAndPassword(email, password));

  Future<void> signInWithGoogle() async =>
      signIn(_authService.signInWithGoogle);

  signOut() async {
    signinOut = true;
    await _authService.signOut();
    signinOut = false;
    authState = AuthState.loggedOut;
  }
}
