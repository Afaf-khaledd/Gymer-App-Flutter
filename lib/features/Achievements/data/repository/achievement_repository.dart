import 'package:gymer/core/helpers/apiService.dart';
import 'package:gymer/core/helpers/error_handler.dart';
import 'package:gymer/core/helpers/local_storage.dart';
import 'package:gymer/features/Achievements/data/models/achievement_model.dart';

class AchievementRepository {
  final ApiService apiService;
  AchievementRepository({required this.apiService});

  Future<Achievement> fetchAchievements() async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) {
        throw Exception('No token found');
      }
      final response = await apiService.get(
        '/progresstracking/achievements',
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return Achievement.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to fetch achievements');
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}
