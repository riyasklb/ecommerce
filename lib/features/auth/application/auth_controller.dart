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
    String errorMessage = 'Login failed. Please try again.';

    if (e is AuthException) {
      //errorMessage = e.message;
    } else if (e is FirebaseAuthException) {
      print('---------------------------');
      errorMessage = AuthException.fromCode(e.code).message;
    } else {
      errorMessage = 'An unexpected error occurred. Please try again.';
    }

    CustomSnackbar.show(context, message: errorMessage, isError: true);
    state = AuthState(errorMessage: errorMessage);
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

    CustomSnackbar.show(context, message: 'Sign-up successful!', isError: false);
    context.go('/productlist');
  } catch (e) {
    String errorMessage = 'Sign-up failed. Please try again.';

    if (e is AuthException) {
      errorMessage = e.message; 
    } else if (e is FirebaseAuthException) {
      errorMessage = e.message ?? 'An authentication error occurred';
    } else {
      errorMessage = e.toString(); 
    }

    CustomSnackbar.show(context, message: errorMessage, isError: true);
    state = AuthState(errorMessage: errorMessage);
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

 
Future<void> sendPasswordReset(String email, BuildContext context) async {
  if (email.isEmpty) {
    CustomSnackbar.show(context, message: 'Please enter your email.', isError: true);
    state = AuthState(errorMessage: 'Please enter your email.');
    return;
  }

  state = AuthState(isLoading: true);
  try {
    await ref.read(authRepositoryProvider).sendPasswordReset(email);
    
    CustomSnackbar.show(context, message: 'Password reset email sent. Check your inbox!', isError: false);
    state = AuthState(errorMessage: 'Password reset email sent. Check your inbox!');
  } catch (e) {
    String errorMessage = 'Failed to send reset email.';
    
    if (e is AuthException) {
      errorMessage = e.message;
    } else if (e is FirebaseAuthException) {
      errorMessage = AuthException.fromCode(e.code).message;
    }

    CustomSnackbar.show(context, message: errorMessage, isError: true);
    state = AuthState(errorMessage: errorMessage);
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
