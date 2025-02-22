import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/CustomTextFormField.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/helpers/validators.dart';
import 'package:gymer/core/utils/colors.dart';
import '../../../Questionnaire/presentation/views/goalScreen.dart';
import '../../../Questionnaire/presentation/views/onboardingQ.dart';
import '../view model/AuthCubit/auth_cubit.dart';
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
    emailController.dispose();
    fullNameController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        fullNameController.text.trim(),
        fullNameController.text.split(' ').first.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          /*if (state is AuthLoading) {
            EasyLoading.show(status: 'Loading...');
          } else {
            EasyLoading.dismiss();
          }*/
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingQ(
                  label: 'Goal',
                  number: '1',
                  rightPadding: 0,
                  labelSize: 50,
                  nextScreen: GoalScreen(),
                ),
              ),
            );
          } else if (state is AuthError) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 80),
                    _buildLabel("Full Name"),
                    CustomTextFormField(
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                      hintText: 'Enter Your Name',
                      validator: Validators.validateFullName,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel("Email"),
                    CustomTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'example@example.com',
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel("Password"),
                    CustomTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      hintText: '***',
                      validator: Validators.validatePassword,
                    ),
                    const SizedBox(height: 15),
                    _buildLabel("Confirm Password"),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      hintText: '***',
                      validator: (value) =>
                          Validators.validateConfirmPassword(value, passwordController.text),
                    ),
                    const SizedBox(height: 45),
                    state is AuthLoading
                        ? const Center(child: CircularProgressIndicator(color: ColorsManager.goldColorO1,))
                        : CustomBlackButton(
                      label: 'Sign Up',
                      onPressed: _submitForm,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.leagueSpartan(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: ColorsManager.goldColorO1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      "  $text",
      style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18),
    );
  }
}