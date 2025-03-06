import 'dart:developer';
import 'package:gymer/features/Favorite/data/models/favoriteModel.dart';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/error_handler.dart';
import '../../../../core/helpers/local_storage.dart';

class FavoriteRepository{
  final ApiService apiService;
  FavoriteRepository({required this.apiService});

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
        return FavoriteModel.fromJson(response.data['data']);
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }

  Future<bool> isFavorite(String machineName) async {
    try {
      final favoriteModel = await getFavorite();
      bool isFav = favoriteModel.favouriteMachines.any((machine) => machine.machineName == machineName);
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
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
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
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}