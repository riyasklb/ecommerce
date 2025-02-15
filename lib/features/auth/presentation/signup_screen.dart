import 'package:ecommerce/core/errors/auth_exeption.dart';
import 'package:ecommerce/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_text_field.dart';

import '../data/auth_provider.dart';


class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

  Future<void> _signUp() async {
    setState(() => isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signUp(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
      context.go('/products');
    } catch (e) {
      setState(() {
        errorMessage = e is AuthException ? e.message : 'Sign-up failed';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: emailController,
              label: 'Email',
              icon: Icons.email,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              controller: passwordController,
              label: 'Password',
              isPassword: true,
              icon: Icons.lock,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Create Account',
              isLoading: isLoading,
              onPressed: _signUp,
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            TextButton(
              onPressed: () => context.push('/login'),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
