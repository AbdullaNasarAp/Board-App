import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth;

  AuthProvider(this.auth);
  bool isLoading = false;

  Stream<User?> user() {
    return auth.authStateChanges();
  }

  bool get loading => isLoading;

  Future<String> signIn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      isLoading = false;
      notifyListeners();
      return Future.value("");
    } on FirebaseAuthException catch (ex) {
      isLoading = false;
      notifyListeners();
      return Future.value(ex.message);
    }
  }
}
