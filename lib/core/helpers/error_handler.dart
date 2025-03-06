import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleError(dynamic error) {
    try {
      if (error is DioException) {
        if (error.response != null) {
          final responseData = error.response?.data;

          if (responseData is Map<String, dynamic>) {
            if (responseData.containsKey("message")) {
              return responseData["message"];
            } else if (responseData.containsKey("error")) {
              return responseData["error"];
            }
          }

          return "Server error: ${error.response?.statusMessage ?? 'Unknown error'} (Code: ${error.response?.statusCode})";
        }

        return "Network error: ${error.message ?? 'Please check your internet connection.'}";
      } else if (error is Map<String, dynamic>) {
        return error["message"] ?? "An unexpected server error occurred.";
      } else if (error is String) {
        return error;
      }
    } catch (e) {
      return "Error parsing response. Please try again.";
    }

    return "An unexpected error occurred. Please try again.";
  }
}