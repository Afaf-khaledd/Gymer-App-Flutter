import 'package:dio/dio.dart';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/local_storage.dart';
import '../models/machineModel.dart';

class MachineRepository {
  final ApiService apiService;

  MachineRepository({required this.apiService});

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
        return "Server error: ${error.response?.statusMessage ??
            'Unknown error'}";
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

  Future<MachineModel> sendMachineImage(String imageBase64) async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) {
        throw Exception("Authentication error: Token is missing.");
      }

      final response = await apiService.post(
        "/aiorchestrator/imagerecognition",
        data: {
          'image':imageBase64,
        },
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return MachineModel.fromJson(response.data["data"]);

      } else {

        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      throw Exception(_handleError(dioError));
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}