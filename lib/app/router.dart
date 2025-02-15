
// router.dart
import 'package:ecommerce/features/splash/presentation/splash_screen.dart';

import 'package:go_router/go_router.dart';


final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
   // GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
   // GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
  //  GoRoute(path: '/products', builder: (context, state) => const ProductListScreen()),
  ],
);