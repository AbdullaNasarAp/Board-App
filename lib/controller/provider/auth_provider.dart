import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth firebase;
  AuthProvider(this.firebase);
  bool isLoading = false;
  Stream<User?> stream() => firebase.authStateChanges();
  bool get loading => isLoading;
  Future<void> signOut() async {
    await firebase.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      await firebase.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
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

  void signInPressed(email, password, context) async {
    final message = await signIn(email, password);
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    }
    notifyListeners();
  }

  Future<String> signUp(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();
      await firebase.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
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

  void signUpPressed(email, password, context) async {
    final message = await signUp(email, password);
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    }
    notifyListeners();
  }

  Future<String> googleSignIn() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isLoading = false;
        notifyListeners();
        return Future.value('Occured an error while sign in');
      }
      final cred = await result.authentication;
      final exites = await firebase.fetchSignInMethodsForEmail(result.email);
      if (exites.isEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value("User doesn't exists");
      }
      await firebase.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: cred.accessToken, idToken: cred.idToken));
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> appleSignIn() async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      final exites = await firebase.fetchSignInMethodsForEmail(result.email!);
      if (exites.isEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value("User doesn't exists");
      }
      await firebase.signInWithCredential(OAuthProvider('apple.com').credential(
          accessToken: result.authorizationCode,
          idToken: result.identityToken));
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on SignInWithAppleException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.toString());
    }
  }

  Future<String> googleSignUp() async {
    try {
      isLoading = true;
      notifyListeners();
      final isLogged = await GoogleSignIn().isSignedIn();
      if (isLogged) GoogleSignIn().signOut();
      final result = await GoogleSignIn().signIn();
      if (result == null) {
        isLoading = false;
        notifyListeners();
        return Future.value('Occured an error while sign in');
      }
      final cred = await result.authentication;
      final exites = await firebase.fetchSignInMethodsForEmail(result.email);
      if (exites.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value("User already exists!");
      }
      await firebase.signInWithCredential(GoogleAuthProvider.credential(
          accessToken: cred.accessToken, idToken: cred.idToken));
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  Future<String> appleSignUp() async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);
      final exites = await firebase.fetchSignInMethodsForEmail(result.email!);
      if (exites.isNotEmpty) {
        isLoading = false;
        notifyListeners();
        return Future.value("User already exists!");
      }
      await firebase.signInWithCredential(OAuthProvider('apple.com').credential(
          accessToken: result.authorizationCode,
          idToken: result.identityToken));
      isLoading = false;
      notifyListeners();
      return Future.value('');
    } on SignInWithAppleException catch (e) {
      isLoading = false;
      notifyListeners();
      return Future.value(e.toString());
    }
  }

  void googleSignUpPressed(context) async {
    final message = await googleSignUp();
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    }
    notifyListeners();
  }

  void googleSignInPressed(context) async {
    final message = await googleSignIn();
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    }
    notifyListeners();
  }

  void appleSignUpPressed(context) async {
    final message = await appleSignUp();
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    }
    notifyListeners();
  }

  void appleSignInPressed(context) async {
    final message = await appleSignIn();
    if (message == '') {
      return;
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
        ),
      );
    }
    notifyListeners();
  }

  bool obscureText = true;
  void toggle() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
