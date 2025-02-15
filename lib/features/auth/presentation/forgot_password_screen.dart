import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../data/auth_provider.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  String message = '';
  bool isLoading = false;

  Future<void> _resetPassword() async {
    setState(() => isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .sendPasswordReset(emailController.text.trim());
      setState(() {
        message = 'Password reset email sent. Check your inbox!';
      });
    } catch (e) {
      setState(() {
        message = 'Failed to send reset email.';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _resetPassword,
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
