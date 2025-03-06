import 'package:intl/intl.dart';
import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/core/helpers/local_storage.dart';
import '../../../../core/helpers/error_handler.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository({required this.apiService});
  Future<bool> checkWorkoutPlan() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      final response = await apiService.get(
        "/profile/retrieve/workoutplan",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> workoutData =
            response.data['data']['workout'] ?? {};

        if (workoutData.isEmpty) {
          return false;
        }
        return true;
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }

  Future<Map<String, String>> getWorkoutPlan() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      DateTime now = DateTime.now();
      String dayName = DateFormat('EEEE').format(now);

      final response = await apiService.get(
        "/profile/retrieve/workoutplan/$dayName",
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> workoutData =
            response.data['data']['workout'] ?? {};

        if (workoutData.isEmpty) {
          return {};
        }
        return workoutData
            .map((key, value) => MapEntry(key.toString(), value.toString()));
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}
