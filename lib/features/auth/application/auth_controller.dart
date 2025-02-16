import 'package:ecommerce/app/router.dart';
import 'package:ecommerce/core/errors/auth_exeption.dart';
import 'package:ecommerce/features/auth/data/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// 📌 Authentication State Model
class AuthState {
  final bool isLoading;
  final String errorMessage;
  final User? user; // 🔹 Track logged-in user

  AuthState({this.isLoading = false, this.errorMessage = '', this.user});
}

// 📌 Authentication Controller using StateNotifier
class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(AuthState());

  final Ref ref;

  // 📌 Check Authentication Status
  bool get isAuthenticated => state.user != null;

  // 📌 Login Method
Future<void> signIn(String email, String password, BuildContext context) async {
  state = AuthState(isLoading: true);
  try {
    await ref.read(authRepositoryProvider).signIn(email, password);
    print('-----------------------------------✅ Login successful------------------------------------------');

    navigateAfterLogin(); // 🔹 Safe Navigation Function

  } catch (e) {
    state = AuthState(errorMessage: e is AuthException ? e.message : 'Login failed');
  } finally {
    state = AuthState(isLoading: false);
  }
}


  // 📌 Sign-Up Method
  Future<void> signUp(String email, String password, BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      final userCredential = await ref.read(authRepositoryProvider).signUp(email, password);
      state = AuthState(user: userCredential.user); // ✅ Store user after signup
      navigateAfterLogin(); // Navigate after successful signup
    } catch (e) {
      state = AuthState(errorMessage: e is AuthException ? e.message : 'Sign-up failed');
    } finally {
      state = AuthState(isLoading: false, user: state.user);
    }
  }

  // 📌 Password Reset
  Future<void> sendPasswordReset(String email) async {
    if (email.isEmpty) {
      state = AuthState(errorMessage: 'Please enter your email.');
      return;
    }
    state = AuthState(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).sendPasswordReset(email);
      state = AuthState(errorMessage: 'Password reset email sent. Check your inbox!');
    } catch (e) {
      state = AuthState(errorMessage: e is AuthException ? e.message : 'Failed to send reset email.');
    } finally {
      state = AuthState(isLoading: false);
    }
  }

  // 📌 Logout
   Future<void> logout(BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).logout();
      context.go('/login'); // ✅ Navigate to Login Screen after logout
    } catch (e) {
      state = AuthState(errorMessage: 'Logout failed. Please try again.');
    } finally {
      state = AuthState(isLoading: false);
    }
  }

}

// 📌 Riverpod Providers
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});

final emailControllerProvider = Provider.autoDispose((ref) => TextEditingController());
final passwordControllerProvider = Provider.autoDispose((ref) => TextEditingController());
