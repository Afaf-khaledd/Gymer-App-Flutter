import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/core/helpers/local_storage.dart';
import 'package:gymer/features/Authentication/data/models/userModel.dart';
import 'package:gymer/features/Favorite/data/models/favoriteModel.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository({required this.apiService});

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

  Future<FavoriteModel> getFavorite() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");
      log(token);
      final response = await apiService.get(
        "/favourite/retrieve",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        log('success retrieve');
        log(FavoriteModel.fromJson(response.data['data']).toString());
        return FavoriteModel.fromJson(response.data['data']);
      } else {
        log('failed to retrieve');
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
