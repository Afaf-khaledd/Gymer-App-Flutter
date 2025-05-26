import 'package:gymer/features/Analysis/data/models/activityModel.dart';
import 'package:intl/intl.dart';

import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/error_handler.dart';
import '../../../../core/helpers/local_storage.dart';

class AnalysisRepository {
  final ApiService apiService;
  AnalysisRepository({required this.apiService});

  Future<ActivityModel> progressTracking({required int count}) async {
    try {
      String? token = await LocalStorage.getToken();
      if (token == null) throw Exception("No token found");

      DateTime now = DateTime.now();
      String day = DateFormat('EEEE').format(now);
      print(day);

      final response = await apiService.post(
        "/progresstracking/progress",
        data: {
          "day": day, //day
          "count": count,
        },
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return ActivityModel.fromJson(response.data["data"]);
      } else {
        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}