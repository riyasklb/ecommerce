import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../data/auth_provider.dart';

final forgotPasswordMessageProvider = StateProvider<String>((ref) => '');
final forgotPasswordLoadingProvider = StateProvider<bool>((ref) => false);

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final message = ref.watch(forgotPasswordMessageProvider);
    final isLoading = ref.watch(forgotPasswordLoadingProvider);

    Future<void> resetPassword() async {
      ref.read(forgotPasswordLoadingProvider.notifier).state = true;
      try {
        await ref.read(authRepositoryProvider).sendPasswordReset(
          emailController.text.trim(),
        );
        ref.read(forgotPasswordMessageProvider.notifier).state =
            'Password reset email sent. Check your inbox!';
      } catch (_) {
        ref.read(forgotPasswordMessageProvider.notifier).state =
            'Failed to send reset email.';
      } finally {
        ref.read(forgotPasswordLoadingProvider.notifier).state = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
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
              isLoading: isLoading,
              onPressed: resetPassword,
            ),
            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  message,
                  style: TextStyle(
                    color: message.contains('failed') ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
