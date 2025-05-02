import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/toast.dart';

class AuthProvider extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> login({
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onError
  }) async {
    if (password.isEmpty || email.isEmpty) {
      showErrorToast(msg: 'Email and password are required');
      onError();
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      final message = e.message ?? 'Unknown error occurred';
      onError();
      showErrorToast(msg: 'Login failed: $message');
      debugPrint('Login failed: $message');
    } finally {
      notifyListeners();
    }
  }

  Future<void> register({
    required String userName,
    required String email,
    required String password,
    required VoidCallback onSuccess,
    required VoidCallback onError
  }) async {
    if (userName.isEmpty) {
      showErrorToast(msg: 'User name is required');
      onError();
      return;
    }
    if (email.isEmpty) {
      showErrorToast(msg: 'Email Address is required');
      onError();
      return;
    }
    if (password.isEmpty) {
      showErrorToast(msg: 'Password is required');
      onError();
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      final message = e.message ?? 'Unknown error occurred';
      onError();
      showErrorToast(msg: 'Registration failed: $message');
      debugPrint('Registration failed: $message');
    } finally {
      notifyListeners();
    }
  }

  Future<void> forgotPassword({
    required String email,
    required VoidCallback onSuccess,
    required VoidCallback onError
  }) async {
    if (email.isEmpty) {
      showErrorToast(msg: "Please enter your Email Address");
      onError();
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showSuccessToast(msg: "Password reset link sent to $email");
      onSuccess();
    } on FirebaseAuthException catch (e) {
      final message = e.message ?? 'Unknown error occurred';
      showErrorToast(msg: "Error: $message");
      debugPrint('Error: $message');
      onError();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }
}