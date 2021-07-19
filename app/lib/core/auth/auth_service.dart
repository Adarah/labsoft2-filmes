import 'dart:convert';

import 'package:app/models/movie_user.dart';
import 'package:app/services/backend_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

abstract class AuthService {
  // MovieUser? get currentUser;

  Stream<MovieUser?> authStateChanges();

  Future<MovieUser?> signInWithEmailAndPassword(String email, String password);

  Future<MovieUser?> signInWithGoogle();

  Future<void> signOut();
}

class FirebaseAuthService implements AuthService {
  final _firebaseAuth = Firebase.FirebaseAuth.instance;
  var _googleSignIn = GoogleSignIn(scopes: ['email']);

  BackendService _backendService;

  FirebaseAuthService(BackendService backendService)
      : _backendService = backendService;

  @override
  Stream<MovieUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) {
        return null;
      }
      return await _backendService.getUser(user.uid);
    });
  }

  @override
  Future<MovieUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return insecureLogin(userCredential.user!);
  }

  @override
  Future<MovieUser?> signInWithGoogle() async {
    final googleSignInAcc = await _googleSignIn.signIn();
    if (googleSignInAcc == null) {
      return null;
    }

    final googleAuthentication = await googleSignInAcc.authentication;
    final userCredential = await _firebaseAuth
        .signInWithCredential(Firebase.GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    ));
    return insecureLogin(userCredential.user!);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<MovieUser> insecureLogin(Firebase.User firebaseUser) async {
    try {
      return _backendService.getUser(firebaseUser.uid);
    } catch (e) {
      return _backendService.createUser(firebaseUser);
    }
  }
}
