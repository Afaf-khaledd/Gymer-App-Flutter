import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/features/Questionnaire/data/models/quesitionnaireModel.dart';

import '../../../../core/helpers/local_storage.dart';

class QuestionnaireRepository{
  final ApiService apiService;

  QuestionnaireRepository({required this.apiService});

  Future<bool> submitQuestionnaire(QuestionnaireModel questionnaire) async {
    try {
      String? token = await LocalStorage.getToken();
      print("Retrieved token: $token");
      if (token == null) {
        Fluttertoast.showToast(msg: "Error: Token is missing.");
        return false;
      }

      final requestData = questionnaire.toJson();
      print("Submitting questionnaire: $requestData");

      Response response = await apiService.post(
        "/questionnaire/submit",
        data: requestData,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Questionnaire submitted successfully.");
        return true;
      } else {
        Fluttertoast.showToast(msg: "Error: ${response.data}");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(msg: "Error submitting questionnaire.");
      return false;
    }
  }
}