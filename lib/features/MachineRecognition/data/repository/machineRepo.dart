import '../../../../core/helpers/apiService.dart';
import '../../../../core/helpers/error_handler.dart';
import '../../../../core/helpers/local_storage.dart';
import '../models/machineModel.dart';

class MachineRepository {
  final ApiService apiService;

  MachineRepository({required this.apiService});

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

        throw Exception(ErrorHandler.handleError(response.data));
      }
    } catch (error) {
      throw Exception(ErrorHandler.handleError(error));
    }
  }
}