import 'package:ecommerce/core/errors/auth_exeption.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthRepository {
  User? get currentUser;
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  Future<void> sendPasswordReset(String email);
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository(this._firebaseAuth);

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    }
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromCode(e.code);
    }
  }

    Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
