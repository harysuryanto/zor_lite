import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';

class UserAuth extends ChangeNotifier {
  FirebaseAuth instance = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus {
    return instance.authStateChanges();
  }

  bool get isLoggedIn {
    return instance.currentUser != null;
  }

  Future<void> login({required String email, required String password}) async {
    await instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    notifyListeners();
  }

  Future<void> logout() async {
    await instance.signOut();
  }
}
