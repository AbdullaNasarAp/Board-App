import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<String> signUp(String email, String password) async {
    try {
      /// checking the loading ///////
      isLoading = true;
      notifyListeners();
      ////////////////////////////////
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  ///////google signin//////////////////////
  Future<String> googleSignin() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) {
        GoogleSignIn().signOut();
      }
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isLoading = false;
        notifyListeners();
        return Future.value('Ocuured an error while sign in ');
      }
      final credential = await result.authentication;
      final exitsUser = await auth.fetchSignInMethodsForEmail(result.email);
      if (exitsUser.isEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value('User does not exits!');
      }
      await auth.signInWithCredential(
        GoogleAuthProvider.credential(
            accessToken: credential.accessToken, idToken: credential.idToken),
      );
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> appleSignin() async {
    return Future.value('');
  }

  Future<String> googleSignup() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) {
        GoogleSignIn().signOut();
      }
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isLoading = false;
        notifyListeners();
        return Future.value('Ocuured an error while sign in ');
      }
      final credential = await result.authentication;
      final exitsUser = await auth.fetchSignInMethodsForEmail(result.email);
      if (exitsUser.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value('User already exits!');
      }
      await auth.signInWithCredential(
        GoogleAuthProvider.credential(
            accessToken: credential.accessToken, idToken: credential.idToken),
      );
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> appleSignup() async {
    return Future.value('');
  }
}
