import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthService {
  User? get currentUser;

  Stream<User?> authStateChanges();

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<User?> signInWithGoogle();

  Future<void> signOut();
}

class FirebaseAuthService implements AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  var _googleSignIn = GoogleSignIn(scopes: ['email']);

  FirebaseAuthService();

  @override
  get currentUser => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleSignInAcc = await _googleSignIn.signIn();
    if (googleSignInAcc == null) {
      return null;
    }

    final googleAuthentication = await googleSignInAcc.authentication;
    final userCredential =
        await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    ));
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
