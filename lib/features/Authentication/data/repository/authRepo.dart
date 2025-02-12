import 'dart:convert';

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

  // call get api to get user data and save it
  Future<UserModel> login(
      Map<String, String> credentials, String password) async {
    try {
      final response = await apiService.post("/authentication/login", data: {
        ...credentials,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final token = data['token'];

        final user = UserModel(
          userId: '',
          fullName: '',
          userName: credentials.containsKey('username')
              ? credentials['username']!
              : '',
          email: credentials.containsKey('email') ? credentials['email']! : '',
          token: token,
        );

        await LocalStorage.saveToken(token);
        await LocalStorage.saveUserData(user);

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
          userId: userCreated['_id'],
          fullName: userCreated['fullName'],
          userName: userCreated['userName'],
          email: userCreated['email'],
          token: token,
        );

        await LocalStorage.setRememberMe(true);
        await LocalStorage.saveToken(token);
        await LocalStorage.saveUserData(user);

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

  Future<void> logout() async {
    await LocalStorage.removeToken();
    await LocalStorage.removeUserData();
    await LocalStorage.clearStorage();
  }
}
