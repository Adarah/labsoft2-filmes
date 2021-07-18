import 'package:app/core/auth/auth_service.dart';
import 'package:app/models/movie_user.dart';
import 'package:app/models/streaming_service.dart';
import 'package:app/services/backend_service.dart';
import 'package:flutter/foundation.dart';

enum AuthState {
  loggedIn,
  loggedOut,
  unknown,
}

class AuthViewmodel with ChangeNotifier {
  MovieUser? _user;

  MovieUser? get user => _user;

  set user(MovieUser? value) {
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
  BackendService _backendService;

  AuthViewmodel(
    AuthService authService,
    BackendService backendService,
  )   : _authService = authService,
        _backendService = backendService {
    _authService.authStateChanges().listen((movieUser) async {
      if (movieUser == null) {
        user = null;
        authState = AuthState.loggedOut;
      } else {
        user = movieUser;
        authState = AuthState.loggedIn;
      }
      print('in stream');
      print(user);
    },
    onError: (e) {
      print(e);
      authState = AuthState.loggedOut;
    });
  }

  Future<void> signIn(Future<MovieUser?> Function() enter) async {
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

  void toggleService(StreamingService svc, bool isEnabled) async {
    final userServices = user!.streamingServices.toSet();
    if (isEnabled) {
      userServices.add(svc);
    } else {
      userServices.remove(svc);
    }
    user = await _backendService.updateStreamingServices(userServices.toList(), user!.id);
  }
}
