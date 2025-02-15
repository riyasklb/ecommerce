import 'package:ecommerce/core/errors/auth_exeption.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../data/auth_provider.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

  Future<void> _login() async {
    setState(() => isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signIn(
            emailController.text.trim(),
            passwordController.text.trim(),
          );
      context.go('/productlist');
    } catch (e) {
      setState(() {
        errorMessage = e is AuthException ? e.message : 'Login failed';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
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
              text: 'Login',
              isLoading: isLoading,
              onPressed: _login,
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
