import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../application/auth_controller.dart'; // Use auth controller

// 🔹 Providers
final forgotPasswordMessageProvider = StateProvider<String>((ref) => '');
final forgotPasswordLoadingProvider = StateProvider<bool>((ref) => false);
final emailControllerProvider = Provider.autoDispose((ref) => TextEditingController());

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final authController = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: emailController,
              label: 'Enter your email',
              icon: Icons.email,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Send Reset Email',
              isLoading: authState.isLoading,
              onPressed: () async {
                await authController.sendPasswordReset(emailController.text.trim());
              },
            ),
            if (authState.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  authState.errorMessage,
                  style: TextStyle(
                    color: authState.errorMessage.contains('failed') ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            TextButton(
              onPressed: () => context.pop(), // Back to login
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
