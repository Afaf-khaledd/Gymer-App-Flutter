import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<void> pickImage(BuildContext context,Function(String) onImagePicked) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.add_a_photo_outlined),
                title: Text("Take a Photo", style: GoogleFonts.dmSans(
                    fontSize: 18, fontWeight: FontWeight.w500)),
                onTap: () async {
                  Navigator.pop(context);
                  final imageBase64 = await _getImage(ImageSource.camera);
                  if (imageBase64 != null) {
                    onImagePicked(imageBase64);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text("Choose from Gallery", style: GoogleFonts.dmSans(
                    fontSize: 18, fontWeight: FontWeight.w500)),
                onTap: () async {
                  Navigator.pop(context);
                  final imageBase64 = await _getImage(ImageSource.gallery);
                  if (imageBase64 != null) {
                    onImagePicked(imageBase64);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<String?> _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      File imageFile = File(image.path);
      List<int> imageBytes = await imageFile.readAsBytes();
      return base64Encode(imageBytes);
    }
    return null;
  }


  static Future<File?> pickAndCropImage(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
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
            lockAspectRatio: false,
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
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    } catch (e) {
      debugPrint("Error picking/cropping image: $e");
    }
    return null;
  }
}
