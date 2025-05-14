import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Questionnaire/presentation/views/activityLevelScreen.dart';
import 'package:gymer/features/Questionnaire/presentation/views/fitnessLevelScreen.dart';
import 'package:shimmer/shimmer.dart';
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
import 'CustomDropdownFormField.dart';
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
  late TextEditingController goalWeightController;
  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController fullNameController;
  late String profileUrl;
  String? selectedActivityLevel;
  String? selectedFitnessGoal;
  String? selectedGender;
  String? selectedWorkoutDuration;
  String? selectedFitnessLevel;
  List<String> selectedWorkoutDays = [];
  List<String> selectedInjuries = [];


  File? _profileImage;
  //final ImagePicker _picker = ImagePicker();
  final List<String> fitnessGoals = [
    "Lose Weight",
    "Gain Weight",
    "Muscle Gain",
    "Endurance",
  ];

  final List<String> workoutDurations = [
    "About 15 Min",
    "About 30 Min",
    "About 1 Hour",
    "More Than 1 Hour",
  ];
  final List<String> workoutDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> injuriesList = [
    "No injuries", "Shoulder", "Arm", "Chest", "Back", "Breathing", "Leg", "Calf", "Hip", "Glutes"
  ];
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    userNameController = TextEditingController();
    weightController = TextEditingController();
    goalWeightController = TextEditingController();
    ageController = TextEditingController();
    heightController = TextEditingController();
    fullNameController = TextEditingController();

    context.read<AuthCubit>().getProfile();
  }

  void _initializeControllers(UserModel user) {
    emailController.text = user.email;
    userNameController.text = user.userName;
    weightController.text = user.currentWeight.toString();
    goalWeightController.text = user.currentWeight.toString();
    heightController.text = "150";
    ageController.text = "22";
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
    goalWeightController.dispose();
    heightController.dispose();
    ageController.dispose();
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
            backgroundColor: Colors.yellow,
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
          backgroundColor: Color.fromRGBO(255, 255, 255, 1.208),
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildShimmerField(),
                    const SizedBox(height: 15),
                    _buildShimmerField(),
                    const SizedBox(height: 15),
                    _buildShimmerField(),
                    const SizedBox(height: 15),
                    _buildShimmerField(),
                    const SizedBox(height: 30),
                    _buildShimmerButton(),
                  ],
                ),
              );
            } else  if (state is ProfileRetrieved) {
              _initializeControllers(state.user);
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 10),
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
                      CustomFormText(text:"General Information"),
                      const SizedBox(height: 15),
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
                      SizedBox(height: 20,),
                      CustomFormText(text:"Fitness Information"),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormText(text: "Age"),
                                CustomTextFormField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  hintText: 'Enter age',
                                  validator: Validators.validateNotEmpty,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormText(text: "Gender"),
                                CustomDropdownFormField<String>(
                                  hintText: 'Select Gender',
                                  value: selectedGender,
                                  items: ['Male', 'Female'],
                                  onChanged: (value) => setState(() => selectedGender = value),
                                  validator: (value) => value == null ? 'Please select a gender' : null,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormText(text: "Current Weight (kg)"),
                                CustomTextFormField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  hintText: 'ex. 50kg',
                                  validator: Validators.validateNotEmpty,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomFormText(text: "Goal Weight (kg)"),
                                CustomTextFormField(
                                  controller: goalWeightController,
                                  keyboardType: TextInputType.number,
                                  hintText: 'ex. 90kg',
                                  validator: Validators.validateNotEmpty,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Height (cm)"),
                      CustomTextFormField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        hintText: 'ex. 150cm',
                        validator: Validators.validateNotEmpty,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text: "Activity Level"),
                      CustomDropdownFormField<String>(
                        hintText: 'Select Activity Level',
                        value: selectedActivityLevel,
                        items: ActivityLevelScreen.activity_level,
                        onChanged: (value) => setState(() => selectedActivityLevel = value),
                        validator: (value) => value == null ? 'Please select a Activity Level' : null,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text: "Fitness Goal"),
                      CustomDropdownFormField<String>(
                        hintText: 'Select Goal',
                        value: selectedFitnessGoal,
                        items: fitnessGoals,
                        onChanged: (value) => setState(() => selectedFitnessGoal = value),
                        validator: (value) => value == null ? 'Please select a goal' : null,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Workout Duration"),
                      CustomDropdownFormField<String>(
                        hintText: 'Select Workout Duration',
                        value: selectedWorkoutDuration,
                        items: workoutDurations,
                        onChanged: (value) => setState(() => selectedWorkoutDuration = value),
                        validator: (value) => value == null ? 'Please select a workout duration' : null,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Available Workout Days"),
                      Wrap(
                        spacing: 8.0,
                        children: workoutDays.map((day) {
                          final isSelected = selectedWorkoutDays.contains(day);
                          return FilterChip(
                            label: Text(day),
                            selected: isSelected,
                            selectedColor: ColorsManager.goldColorO60.withOpacity(0.4),
                            backgroundColor: Colors.white70,
                            onSelected: (selected) {
                              setState(() {
                                isSelected
                                    ? selectedWorkoutDays.remove(day)
                                    : selectedWorkoutDays.add(day);
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Fitness Level"),
                      CustomDropdownFormField<String>(
                        hintText: 'Select Fitness Level',
                        value: selectedFitnessLevel,
                        items: FitnessLevelScreen.fitness_level,
                        onChanged: (value) => setState(() => selectedFitnessLevel = value),
                        validator: (value) => value == null ? 'Please select a fitness level' : null,
                      ),
                      const SizedBox(height: 15),
                      CustomFormText(text:"Injuries (if any)"),
                      Wrap(
                        spacing: 8.0,
                        children: injuriesList.map((injury) {
                          final isSelected = selectedInjuries.contains(injury);
                          return FilterChip(
                            label: Text(injury),
                            selected: isSelected,
                            selectedColor: ColorsManager.goldColorO60.withOpacity(0.4),
                            backgroundColor: Colors.white70,
                            onSelected: (selected) {
                              setState(() {
                                if (injury == "No injuries") {
                                  if (selected) {
                                    selectedInjuries = ["No injuries"];
                                  } else {
                                    selectedInjuries.remove("No injuries");
                                  }
                                } else {
                                  selectedInjuries.remove("No injuries");
                                  if (isSelected) {
                                    selectedInjuries.remove(injury);
                                  } else {
                                    selectedInjuries.add(injury);
                                  }
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),
                      state is ProfileLoading
                          ? _buildShimmerButton()
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
  Widget _buildShimmerField() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  Widget _buildShimmerButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
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