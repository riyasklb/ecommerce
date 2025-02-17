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

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    final _formKey = GlobalKey<FormState>(); 

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text(
          'Sign Up',
          style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

           
              Center(
                child: Image.asset(
                AppImages.   signupimage,
                  height: 350,
                  width: 350,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

          
              CustomTextField(
                controller: emailController,
                label: 'Email',
                hintText: 'Enter your email',
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

             CustomTextField(
  controller: passwordController,
  label: 'Password',
  hintText: 'Enter your password',
  icon: Icons.lock,
  obscureText: !ref.watch(passwordVisibilityProvider), 
  suffixIcon: IconButton(
    icon: Icon(
      ref.watch(passwordVisibilityProvider) ? Icons.visibility : Icons.visibility_off,
    ),
    onPressed: () {
      ref.read(passwordVisibilityProvider.notifier).toggleVisibility();
    },
  ),
  validator: (value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  },
),

              const SizedBox(height: 16),

             
              CustomButton(
                text: 'Create Account',
                isLoading: authState.isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authController.signUp(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      context,
                    );
                  } else {
                    CustomSnackbar.show(context, message: 'Please fill all fields correctly', isError: true);
                  }
                },
              ),

        
              if (authState.errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    authState.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),

            
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => context.push('/login'),
                child: Text(
                  'Already have an account? Login',
                  style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
