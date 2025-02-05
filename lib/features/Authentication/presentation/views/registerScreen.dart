import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/CustomTextFormField.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/utils/Validators.dart';
import 'package:gymer/core/utils/colors.dart';

import 'loginScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle successful registration logic
      print("Form submitted successfully!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Create Account",
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 80),
              Text("  Full Name",
                  style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
              CustomTextFormField(
                controller: fullNameController,
                keyboardType: TextInputType.text,
                hintText: 'Enter Your Name',
                validator: Validators.validateFullName,
              ),
              SizedBox(height: 15),
              Text("  Email",
                  style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
              CustomTextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'example@example.com',
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 15),
              Text("  Password",
                  style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
              CustomTextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                hintText: '*********',
                validator: Validators.validatePassword,
              ),
              SizedBox(height: 15),
              Text("  Confirm Password",
                  style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
              CustomTextFormField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                hintText: '*********',
                validator: (value) => Validators.validateConfirmPassword(value, passwordController.text),
              ),
              SizedBox(height: 45),
              CustomBlackButton(
                label: 'Sign Up',
                onPressed: _submitForm,
              ),
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.leagueSpartan(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(color: ColorsManager.goldColorO1, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}