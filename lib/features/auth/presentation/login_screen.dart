import 'package:ecommerce/core/assets/images.dart';
import 'package:ecommerce/core/widget/custom_snacbar.dart';
import 'package:ecommerce/core/widget/custom_button.dart';
import 'package:ecommerce/core/widget/custom_text_field.dart';
import 'package:ecommerce/features/auth/data/password_visibility_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../application/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authController = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.loginBackground,
                  height: 180,
                ),
                const SizedBox(height: 20),
                Text(
                  "Welcome Back!",
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Sign in to continue",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: emailController,
                            label: 'Email',
                            icon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            }, hintText: '',
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            controller: passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            icon: Icons.lock,
                            isPassword:
                                true, 
                            suffixIcon: IconButton(
                              icon: Icon(
                                ref.watch(passwordVisibilityProvider)
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                ref
                                    .read(passwordVisibilityProvider.notifier)
                                    .toggleVisibility();
                              },
                            ),
                            obscureText: !ref.watch(
                                passwordVisibilityProvider), 
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Password is required';
                              if (value.length < 6)
                                return 'Password must be at least 6 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            text: 'Login',
                            isLoading: authState.isLoading,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await authController.signIn(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  context,
                                );
                               
                              } else {
                                CustomSnackbar.show(context,
                                    message:
                                        'Please fix the errors and try again',
                                    isError: true);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => context.push('/forgot-password'),
                            child: const Text("Forgot Password?",
                                style: TextStyle(color: Colors.blue)),
                          ),
                          TextButton(
                            onPressed: () => context.push('/signup'),
                            child: const Text("Don't have an account? Sign up",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
