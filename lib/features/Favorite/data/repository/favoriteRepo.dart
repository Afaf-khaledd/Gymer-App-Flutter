import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gymer/features/Favorite/data/models/favoriteModel.dart';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/local_storage.dart';

class FavoriteRepository{
  final ApiService apiService;
  FavoriteRepository({required this.apiService});

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

  Future<FavoriteModel> getFavorite()async{
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

  Future<bool> isFavorite(String machineName) async {
    try {
      final favoriteModel = await getFavorite();
      bool isFav = favoriteModel.favouriteMachines.any((machine) => machine.machineName == machineName);
      log("Item in favorites: $isFav");
      return isFav;
    } catch (e) {
      log("Error checking favorite status: $e");
      return false;
    }
  }

  Future<void> addToFavorite(String machineName)async{
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      final response = await apiService.post(
        "/favourite/add",
        data: {
          "machineName": machineName,
        },
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        log('item added successfully');
      } else {
        log('issue in add item!');
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> removeFromFavorite(String machineName)async{
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      final response = await apiService.delete(
        "/favourite/remove",
        data: {
          "machineName": machineName
        },
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        log('item deleted successfully');
      } else {
        log('issue in delete item!');
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}