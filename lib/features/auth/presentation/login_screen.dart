import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:ecommerce/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/auth_controller.dart'; // New controller

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

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
            CustomButton(
              text: 'Login',
              isLoading: authState.isLoading,
              onPressed: () async {
                await authController.signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  context,
                );
              },
            ),
            if (authState.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(authState.errorMessage, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
              ),
            TextButton(
              onPressed: () => context.push('/forgot-password'),
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () => context.push('/signup'),
              child: const Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
