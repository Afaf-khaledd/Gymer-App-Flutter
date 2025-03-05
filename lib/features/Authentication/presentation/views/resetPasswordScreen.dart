import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/CustomTextFormField.dart';
import 'package:gymer/core/helpers/validators.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import '../../../../core/components/customBlackButton.dart';
import 'CustomFormText.dart';
import 'loginScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

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
      final newPassword = passwordController.text;
      context.read<AuthCubit>().resetPassword(widget.email, newPassword);
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
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ResetPasswordSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.green),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  } else if (state is AuthError) {
                    Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //const Spacer(),
                        SizedBox(height: 90),
                        CustomFormText(text:"Password"),
                        CustomTextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          hintText: 'Password',
                          obscureText: true,
                          validator: Validators.validatePassword,
                        ),
                        const SizedBox(height: 20),
                        CustomFormText(text:"Confirm Password"),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.text,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          validator: (value) =>
                              Validators.validateConfirmPassword(
                                  value, passwordController.text),
                        ),
                        SizedBox(height: screenHeight * 0.2),
                        state is AuthLoading
                            ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                            : CustomBlackButton(
                                label: 'Reset', onPressed: _submitForm),
                        SizedBox(height: screenHeight * 0.1),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
