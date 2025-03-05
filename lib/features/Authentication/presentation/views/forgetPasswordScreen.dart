import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/CustomTextFormField.dart';
import 'package:gymer/core/components/customBlackButton.dart';
import 'package:gymer/core/helpers/validators.dart';
import 'package:gymer/features/Authentication/presentation/view%20model/AuthCubit/auth_cubit.dart';
import 'package:gymer/features/Authentication/presentation/views/resetPasswordScreen.dart';

import 'CustomFormText.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<AuthCubit>();
  // }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgetPassword(emailController.text);
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
          "Forgotten Password",
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
                  if (state is ForgetPasswordSuccess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(
                                email: emailController.text)));
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
                        SizedBox(
                          height: 150,
                        ),
                        CustomFormText(text:"Enter Your Email Address"),
                        CustomTextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email Address',
                          validator: Validators.validateEmail,
                        ),
                        SizedBox(height: screenHeight * 0.2),
                        state is AuthLoading
                            ? const Center(child: CircularProgressIndicator(color: Colors.white,))
                            : CustomBlackButton(
                                label: 'Next', onPressed: _submitForm),
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
