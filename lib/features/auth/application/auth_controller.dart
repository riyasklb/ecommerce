import 'package:ecommerce/core/errors/auth_exeption.dart';
import 'package:ecommerce/core/widget/custom_snacbar.dart';
import 'package:ecommerce/features/auth/data/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthState {
  final bool isLoading;
  final String errorMessage;
  final User? user;

  AuthState({this.isLoading = false, this.errorMessage = '', this.user});
}


class AuthController extends StateNotifier<AuthState> {
  AuthController(this.ref) : super(AuthState());

  final Ref ref;

 
  Future<void> _setAuthenticated(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('authenticated', value);
  }


  Future<void> signIn(String email, String password, BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      final userCredential = await ref.read(authRepositoryProvider).signIn(email, password);
      state = AuthState(user: userCredential.user);

      await _setAuthenticated(true); 

      CustomSnackbar.show(context, message: 'Login successful!', isError: false);
      context.go('/productlist'); 
    } catch (e) {
      CustomSnackbar.show(context, message: 'Please fix the errors and try again', isError: true);
      state = AuthState(errorMessage: e is AuthException ? e.message : 'Login failed');
    } finally {
      state = AuthState(isLoading: false, user: state.user);
    }
  }

  
  Future<void> signUp(String email, String password, BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      final userCredential = await ref.read(authRepositoryProvider).signUp(email, password);
      state = AuthState(user: userCredential.user);

      await _setAuthenticated(true); 

      context.go('/productlist'); 
    } catch (e) {
      state = AuthState(errorMessage: e is AuthException ? e.message : 'Sign-up failed');
    } finally {
      state = AuthState(isLoading: false, user: state.user);
    }
  }

  Future<void> logout(BuildContext context) async {
    state = AuthState(isLoading: true);
    try {
      await ref.read(authRepositoryProvider).logout();
      await _setAuthenticated(false);

      state = AuthState(); 
      context.go('/login'); 
    } catch (e) {
      state = AuthState(errorMessage: 'Logout failed. Please try again.');
    }
  }

 
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
}


final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref);
});

final emailControllerProvider = Provider.autoDispose((ref) => TextEditingController());
final passwordControllerProvider = Provider.autoDispose((ref) => TextEditingController());
