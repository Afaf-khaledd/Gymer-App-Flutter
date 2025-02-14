import 'package:dio/dio.dart';
import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/features/Questionnaire/data/models/quesitionnaireModel.dart';

import '../../../../core/helpers/local_storage.dart';

class QuestionnaireRepository {
  final ApiService apiService;

  QuestionnaireRepository({required this.apiService});

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
      } else if (error is Map<String, dynamic> && error.containsKey("message")) {
        return error["message"];
      } else if (error is String) {
        return error;
      }
    } catch (e) {
      return "Error parsing response. Please try again.";
    }
    return "An unexpected error occurred. Please try again.";
  }

  Future<bool> submitQuestionnaire(QuestionnaireModel questionnaire) async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) {
        throw Exception("Authentication error: Token is missing.");
      }

      final requestData = questionnaire.toJson();

      final response = await apiService.post(
        "/questionnaire/submit",
        data: requestData,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        LocalStorage.setSubmitQuest(true);
        return true;
      } else {
        throw Exception(_handleError(response.data));
      }
    } on DioException catch (dioError) {
      final errorMessage = _handleError(dioError);
      throw Exception(errorMessage);
    } catch (e) {
      final errorMessage = "Unexpected error: $e";
      throw Exception(errorMessage);
    }
  }
}