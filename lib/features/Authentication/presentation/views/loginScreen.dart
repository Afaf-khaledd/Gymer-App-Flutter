import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Authentication/presentation/views/forgetPasswordScreen.dart';
import 'package:gymer/features/Authentication/presentation/views/registerScreen.dart';

import '../../../../core/components/CustomTextFormField.dart';
import '../../../../core/helpers/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberMe = true;

  void _toggleRememberMe(bool value) {
    setState(() {
      rememberMe = value;
    });
    // shared preference
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Perform login logic here
      print("Login successful!");
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
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    const Spacer(),
                    Image.asset(AssetsManager.gymMachine1),
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  "  Username or Email",
                  style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18),
                ),
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'example@example.com',
                  validator: Validators.validateEmailOrUsername
                ),
                const SizedBox(height: 15),
                Text(
                  "  Password",
                  style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18),
                ),
                CustomTextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  hintText: '*********',
                  validator: Validators.validatePassword,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: AnimatedToggleSwitch<bool>.dual(
                            current: rememberMe,
                            first: true,
                            second: false,
                            borderWidth: 0.1,
                            height: 25,
                            indicatorSize: const Size(200, 25),
                            onChanged: _toggleRememberMe,
                            style: ToggleStyle(
                              backgroundColor: rememberMe ? ColorsManager.goldColorO1 : Colors.grey[350],
                              indicatorColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Remember Me',
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) => const ForgetPasswordScreen(),
                        ),
                        );
                      },
                      child: Text(
                        'Forget Password?',
                        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                CustomBlackButton(
                  label: 'Login',
                  onPressed: _login,
                ),
                const SizedBox(height: 30,),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don’t have an account? ",
                        style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w700, fontSize: 14, color: ColorsManager.goldColorO1),
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
      ),
    );
  }
}