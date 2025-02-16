
import 'package:ecommerce/features/cart/presentation/cart_screen.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:ecommerce/features/product/presentation/screens/product_detail_screen.dart';
import 'package:ecommerce/features/product/presentation/screens/product_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';

// 📌 Define navigatorKey BEFORE using it
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// 📌 Provider to check authentication from SharedPreferences
final authStatusProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('authenticated') ?? false; // Default: Not authenticated
});

// 📌 App Router Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  final authStatusAsync = ref.watch(authStatusProvider);

  // 📌 Default to '/login' if auth state is still loading
  final initialLocation = authStatusAsync.when(
    data: (isAuthenticated) => isAuthenticated ? '/productlist' : '/login',
    loading: () => '/login', // Show login while checking
    error: (_, __) => '/login', // Handle errors by defaulting to login
  );

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/productlist',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/productdetails',
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: '/cartscreen',
        builder: (context, state) =>  CartScreen(),
      ),
    ],
  );
});

// 📌 Function to Navigate After Login Safely
void navigateAfterLogin() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    navigatorKey.currentState?.context.go('/productlist'); // ✅ Safe navigation
  });
}
