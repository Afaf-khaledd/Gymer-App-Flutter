import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/CustomTextFormField.dart';
import '../../../../core/components/customBlackButton.dart';
import '../../../../core/helpers/validators.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(text: 'ian@example.com');
  TextEditingController userNameController = TextEditingController(text: 'Damon');
  TextEditingController weightController = TextEditingController(text: '80');
  TextEditingController fullNameController = TextEditingController(text: 'Ian Somerhalder');

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    fullNameController.dispose();
    weightController.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // profile
                SizedBox(height: 20,),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage(AssetsManager.defaultProfileImage) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: const Icon(
                              Icons.mode_edit_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text("  Full Name",
                    style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
                CustomTextFormField(
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                  hintText: 'Enter Your Full Name',
                  validator: Validators.validateFullName,
                ),
                SizedBox(height: 15),
                Text("  Username",
                    style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
                CustomTextFormField(
                  controller: userNameController,
                  keyboardType: TextInputType.text,
                  hintText: 'Enter Your Nickname',
                  validator: Validators.validateUserName,
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
                Text("  Weight",
                    style: GoogleFonts.leagueSpartan(fontWeight: FontWeight.w400, fontSize: 18)),
                CustomTextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  hintText: 'ex. 50kg',
                  validator: Validators.validateNotEmpty,
                ),
                //Spacer(),
                SizedBox(height: 30,),
                CustomBlackButton(
                  label: 'Edit',
                  onPressed: (){},
                ),
                //SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
