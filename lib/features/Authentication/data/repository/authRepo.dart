import 'dart:convert';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/local_storage.dart';
import '../models/userModel.dart';

class AuthenticationRepository {
  final ApiService apiService;

  AuthenticationRepository({required this.apiService});

  String _handleError(dynamic error) {
    try {
      if (error is String) {
        final decodedError = jsonDecode(error);
        if (decodedError is Map<String, dynamic> &&
            decodedError.containsKey("message")) {
          return decodedError["message"];
        }
      } else if (error is Map<String, dynamic> &&
          error.containsKey("message")) {
        return error["message"];
      }
    } catch (e) {
      return "Error parsing response. Please try again.";
    }
    return "An unexpected error occurred. Please try again.";
  }

  // call get api to get user data and save it
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post("/authentication/login", data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final token = data['token'];

        final user = UserModel(
          userId: '',
          fullName: '',
          userName: '',
          email: email,
          token: token,
        );

        await LocalStorage.saveToken(token);
        await LocalStorage.saveUserData(user);

        return user;
      } else {
        throw Exception(_handleError(response.data));
      }
    } catch (e) {
      throw Exception(_handleError(e.toString()));
    }
  }

  // set remember me true
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
    } catch (e) {
      throw Exception(_handleError(e.toString()));
    }
  }

  // Logout!! remove remember me
  Future<void> logout() async {
    await LocalStorage.removeToken();
    await LocalStorage.removeUserData();
    await LocalStorage.clearStorage();
  }
}
