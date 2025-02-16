import 'package:ecommerce/features/auth/application/auth_controller.dart';
import 'package:ecommerce/features/cart/presentation/cart_screen.dart';
import 'package:ecommerce/features/product/model/product_model.dart';
import 'package:ecommerce/features/product/presentation/screens/product_detail_screen.dart';
import 'package:ecommerce/features/product/presentation/screens/product_list_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';

// 📌 Global Navigator Key to prevent context disposal issues
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// 📌 App Router Provider
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final isAuthenticated = authState.user != null; // ✅ Check if user is logged in

  return GoRouter(
    navigatorKey: navigatorKey, // ✅ Use Global Key
    initialLocation: isAuthenticated ? '/productlist' : '/login', // 🔹 Auto-redirect

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
        builder: (context, state) => CartScreen(),
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
