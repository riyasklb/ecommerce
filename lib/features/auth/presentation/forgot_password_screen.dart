import 'package:ecommerce/core/assets/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widget/custom_text_field.dart';
import '../../../core/widget/custom_button.dart';
import '../../../core/widget/custom_snacbar.dart';
import '../application/auth_controller.dart';


final emailControllerProvider = Provider.autoDispose((ref) => TextEditingController());

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = ref.watch(emailControllerProvider);
    final authController = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);

    final _formKey = GlobalKey<FormState>(); 

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

           
              Center(
                child: Image.asset(
            AppImages.      forgotpasswordimage, 
                  height: 350,
                  width: 350,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),

           
              CustomTextField(
                controller: emailController,
                label: 'Enter your email',
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
              const SizedBox(height: 16),

              
              CustomButton(
                text: 'Send Reset Email',
                isLoading: authState.isLoading,
             onPressed: () async {
  if (_formKey.currentState!.validate()) {
    await authController.sendPasswordReset(emailController.text.trim(), context);
  } else {
    CustomSnackbar.show(context, message: 'Please enter a valid email', isError: true);
  }
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

              const SizedBox(height: 20),

    
              TextButton(
                onPressed: () => context.pop(),
                child: const Text(
                  'Back to Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
