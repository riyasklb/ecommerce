import 'package:ecommerce/core/errors/auth_exeption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../data/auth_provider.dart';

final loginLoadingProvider = StateProvider<bool>((ref) => false);
final loginErrorProvider = StateProvider<String>((ref) => '');

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isLoading = ref.watch(loginLoadingProvider);
    final errorMessage = ref.watch(loginErrorProvider);

    Future<void> handleLogin() async {
      ref.read(loginLoadingProvider.notifier).state = true;
      try {
        await ref.read(authRepositoryProvider).signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        context.go('/productlist');
      } catch (e) {
        ref.read(loginErrorProvider.notifier).state =
            e is AuthException ? e.message : 'Login failed';
      } finally {
        ref.read(loginLoadingProvider.notifier).state = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(controller: emailController, label: 'Email', icon: Icons.email),
            const SizedBox(height: 12),
            CustomTextField(controller: passwordController, label: 'Password', isPassword: true, icon: Icons.lock),
            const SizedBox(height: 16),
            CustomButton(text: 'Login', isLoading: isLoading, onPressed: handleLogin),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              ),
            TextButton(onPressed: () => context.push('/forgot-password'), child: const Text('Forgot Password?')),
            TextButton(onPressed: () => context.push('/signup'), child: const Text('Don\'t have an account? Sign up')),
          ],
        ),
      ),
    );
  }
}
