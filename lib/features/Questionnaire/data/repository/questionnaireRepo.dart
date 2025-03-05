import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/features/Questionnaire/data/models/quesitionnaireModel.dart';
import '../../../../core/helpers/error_handler.dart';
import '../../../../core/helpers/local_storage.dart';

class QuestionnaireRepository {
  final ApiService apiService;

  QuestionnaireRepository({required this.apiService});

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
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}