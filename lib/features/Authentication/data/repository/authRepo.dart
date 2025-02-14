import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/local_storage.dart';
import '../models/userModel.dart';

class AuthenticationRepository {
  final ApiService apiService;

  AuthenticationRepository({required this.apiService});

  String _handleError(dynamic error) {
    try {
      if (error is DioException) {
        if (error.response != null &&
            error.response?.data is Map<String, dynamic>) {
          final errorData = error.response?.data;
          if (errorData != null && errorData.containsKey("message")) {
            return errorData["message"];
          }
        }
        return "Server error: ${error.response?.statusMessage ?? 'Unknown error'}";
      } else if (error is Map<String, dynamic> &&
          error.containsKey("message")) {
        return error["message"];
      } else if (error is String) {
        return error;
      }
    } catch (e) {
      return "Error parsing response. Please try again.";
    }
    return "An unexpected error occurred. Please try again.";
  }

  Future<UserModel?> login(
      Map<String, String> credentials, String password) async {
    try {
      final response = await apiService.post("/authentication/login", data: {
        ...credentials,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final token = data['token'];

        await LocalStorage.saveToken(token);

        final user = await getProfile();
        return user;
      } else {
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<UserModel> register({
    required String fullName,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post("/authentication/signup", data: {
        'fullName': fullName,
        'userName': userName,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final token = data['token'];
        final userCreated = data['userCreated'];

        final user = UserModel(
          fullName: userCreated['fullName'],
          userName: userCreated['userName'],
          email: userCreated['email'],
          token: token,
        );

        await LocalStorage.setRememberMe(true);
        await LocalStorage.saveToken(token);
        await LocalStorage.setSubmitQuest(false);

        return user;
      } else {
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<UserModel?> getProfile() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      final response = await apiService.get(
        "/profile/retrieve",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final profileData = response.data['data']['profileInfo'];
        print(profileData);
        return UserModel.fromJson(profileData, token);
      } else {
        throw Exception(
            response.data['message'] ?? "Failed to retrieve profile");
      }
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  Future<UserModel?> updateProfile(Map<String, dynamic> updatedData) async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      final response = await apiService.patch(
        "/profile/edit",
        data: updatedData,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final profileData = response.data['data']['profileInfo'];
        print(profileData);
        return UserModel.fromJson(profileData, token);
      } else {
        throw Exception(response.data['message'] ?? "Failed to update profile");
      }
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  Future<String?> updateProfileImage(File imageFile) async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");
      FormData formData = FormData.fromMap({
        "profile": await MultipartFile.fromFile(
          imageFile.path,
        )
      });
      final response = await apiService.patch(
        "/profile/edit/photo",
        data: formData,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "multipart/form-data"
        },
      );

      if (response.statusCode == 200) {
        print('Image uploaded!');
        return response.data['data']['profilePicture'];
      } else {
        throw Exception(response.data['message'] ?? "Failed to update image");
      }
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  Future<Map<String, String>> sendPasswordResetEmail(String email) async {
    try {
      final response =
          await apiService.post('/authentication/forget_password', data: {
        'email': email,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "message": response.data['message'] ??
              "Check your email for reset instructions",
          "token": response.data['token'] ?? ""
        };
      } else {
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<String?> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      final response =
          await apiService.put('/authentication/reset_password/$token', data: {
        'token': token,
        'password': newPassword,
      });

      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw Exception(response.data['message'] ?? "Failed to reset password");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> logout() async {
    await LocalStorage.removeToken();
    await LocalStorage.clearStorage();
  }
}
