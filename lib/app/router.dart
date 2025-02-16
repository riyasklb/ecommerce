import 'package:ecommerce/core/storage/local_storage.dart';
import 'package:ecommerce/features/product/presentation/screens/product_list_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/signup_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    // redirect: (context, state) async {
    //   final token = await ref.read(localStorageProvider).getToken();
    //   if (token == null || (token.isNotEmpty == false)) {
    //     return '/login';
    //   }
    //   return '/productlist';
    // },
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
    ],
  );
});
