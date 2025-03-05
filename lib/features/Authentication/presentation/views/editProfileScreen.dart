import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import '../../../../core/components/BottomNavHandler.dart';
import '../../../../core/components/CustomTextFormField.dart';
import '../../../../core/components/ImagePickerHelper.dart';
import '../../../../core/components/customBlackButton.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/utils/assets.dart';
import '../../../MachineRecognition/presentation/view model/MachineCubit/machine_cubit.dart';
import '../../../MachineRecognition/presentation/views/targetMuscle.dart';
import '../../data/models/userModel.dart';
import '../view model/AuthCubit/auth_cubit.dart';
import 'CustomFormText.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final int _currentIndex = 4;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController userNameController;
  late TextEditingController weightController;
  late TextEditingController fullNameController;
  late String profileUrl;

  File? _profileImage;
  //final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    weightController = TextEditingController();
    fullNameController = TextEditingController();

    context.read<AuthCubit>().getProfile();
  }

  void _initializeControllers(UserModel user) {
    emailController.text = user.email;
    userNameController.text = user.userName;
    weightController.text = user.currentWeight.toString();
    fullNameController.text = user.fullName;
    profileUrl = user.profileUrl!;
  }

  /*Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 90,
      maxWidth: 700,
      maxHeight: 700,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.black87,//ColorsManager.goldColorO60,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: ColorsManager.goldColorO1,
          hideBottomControls: false,
          lockAspectRatio: true,
          aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          ],
        ),
        IOSUiSettings(
          title: 'Crop your image',
          aspectRatioLockEnabled: false
        ),
      ]
    );

    if(croppedFile != null){
      setState(() {
        _profileImage = File(croppedFile.path);
      });
      context.read<AuthCubit>().updateProfileImage(_profileImage!);
    }
  }*/

  Future<void> _pickAndCropImage() async {
    File? pickedImage = await ImagePickerHelper.pickAndCropImage(context);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
      context.read<AuthCubit>().updateProfileImage(_profileImage!);
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    weightController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'fullName': fullNameController.text.trim(),
        'userName': userNameController.text.trim(),
        'email': emailController.text.trim(),
        'currentWeight': int.tryParse(weightController.text.trim()) ?? 0,
      };

      context.read<AuthCubit>().updateProfile(updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          Fluttertoast.showToast(
            msg: "Profile updated successfully!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Navigator.pop(context);
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
        else if (state is ProfileImageUpdated) {
          setState(() {
            profileUrl = state.newImage;
          });
          Fluttertoast.showToast(
            msg: "Profile image updated successfully!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          toolbarHeight: 90,

        ),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial || state is ProfileImageLoading) {
              return const Center(child: CircularProgressIndicator(color: ColorsManager.goldColorO1));
            } else  if (state is ProfileRetrieved) {
              _initializeControllers(state.user);
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              backgroundImage: (profileUrl.isNotEmpty
                                  ? NetworkImage(profileUrl) as ImageProvider
                                  : const AssetImage(
                                  AssetsManager.defaultProfileImage)),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickAndCropImage,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
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
                      CustomFormText(text:"Full Name"),
                      CustomTextFormField(
                        controller: fullNameController,
                        keyboardType: TextInputType.text,
                        hintText: 'Full Name',
                        validator: Validators.validateFullName,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Username"),
                      CustomTextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.text,
                        hintText: 'Username',
                        validator: Validators.validateUserName,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Email Address"),
                      CustomTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email Address',
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Weight"),
                      CustomTextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        hintText: 'ex. 50kg',
                        validator: Validators.validateNotEmpty,
                      ),
                      const SizedBox(height: 30),
                      state is ProfileLoading
                          ? const Center(child: CircularProgressIndicator(color: ColorsManager.goldColorO1,))
                          : CustomBlackButton(
                        label: 'Edit',
                        onPressed: _updateProfile,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavHandler(
          currentIndex: _currentIndex,
          onImagePicked: (_) => ImagePickerHelper.pickImage(context, _handleImagePicked),
        ),
      ),
    );
  }
  void _handleImagePicked(String imageBase64) {
    context.read<MachineCubit>().sendMachineImage(imageBase64);
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TargetMuscle()),
        );
      }
    });
  }
}