import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/CustomTextFormField.dart';
import 'package:gymer/core/helpers/validators.dart';
import '../../../../core/components/customBlackButton.dart';
import 'loginScreen.dart'; // Import the login screen for navigation

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Navigate to Login after successful password reset
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), // Redirect to login
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Set Password",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //const Spacer(),
                  SizedBox(height: 90),
                  Text(
                    "  Password",
                    style: GoogleFonts.leagueSpartan(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    hintText: '**********',
                    obscureText: true,
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "  Confirm Password",
                    style: GoogleFonts.leagueSpartan(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.text,
                    hintText: '**********',
                    obscureText: true,
                    validator: (value) =>
                        Validators.validateConfirmPassword(value, passwordController.text),
                  ),
                  SizedBox(height: screenHeight * 0.2),
                  CustomBlackButton(label: 'Reset', onPressed: _submitForm),
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}